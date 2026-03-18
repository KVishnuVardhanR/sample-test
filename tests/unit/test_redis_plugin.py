# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import pytest
from unittest.mock import MagicMock, patch
from google.adk.agents.callback_context import CallbackContext
from google.adk.models import LlmRequest, LlmResponse
from google.genai import types

from vague_descriptions_checker.utils.callbacks import CallbacksManager

@pytest.fixture
def mock_callbacks_manager():
    os.environ["REDIS_HOST"] = "localhost"
    with patch("vague_descriptions_checker.utils.callbacks.redis.Redis") as MockRedis:
        mock_client = MockRedis.return_value
        manager = CallbacksManager()
        yield manager, mock_client

def test_cache_hit_in_guardrail_with_cache_hit_function(mock_callbacks_manager):
    """Test cache hit in guardrail_with_cache_hit_function."""
    manager, mock_redis = mock_callbacks_manager
    mock_context = MagicMock(spec=CallbackContext)
    mock_context.state = {}
    
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [
        types.Content(role="user", parts=[types.Part.from_text(text="test prompt")])
    ]
    
    # Mock GenAI judge to say YES
    with patch("vague_descriptions_checker.utils.callbacks.genai.Client") as MockClient:
        mock_client_instance = MockClient.return_value
        mock_response = MagicMock()
        mock_response.text = "YES"
        mock_client_instance.models.generate_content.return_value = mock_response
        
        mock_redis.get.return_value = "cached response"
        
        response = manager.guardrail_with_cache_hit_function(mock_context, mock_request)
        
        assert response is not None
        assert response.content.parts[0].text == "cached response"
        expected_key = manager._generate_cache_key("test prompt")
        mock_redis.get.assert_called_with(expected_key)

def test_cache_miss_in_guardrail_with_cache_hit_function(mock_callbacks_manager):
    """Test cache miss in guardrail_with_cache_hit_function."""
    manager, mock_redis = mock_callbacks_manager
    mock_context = MagicMock(spec=CallbackContext)
    mock_context.state = {}
    
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [
        types.Content(role="user", parts=[types.Part.from_text(text="new prompt")])
    ]
    
    # Mock GenAI judge to say YES
    with patch("vague_descriptions_checker.utils.callbacks.genai.Client") as MockClient:
        mock_client_instance = MockClient.return_value
        mock_response = MagicMock()
        mock_response.text = "YES"
        mock_client_instance.models.generate_content.return_value = mock_response
        
        mock_redis.get.return_value = None
        
        response = manager.guardrail_with_cache_hit_function(mock_context, mock_request)
        
        assert response is None
        expected_key = manager._generate_cache_key("new prompt")
        mock_redis.get.assert_called_with(expected_key)

def test_handle_cache_miss_updates_redis(mock_callbacks_manager):
    """Test storage in handle_cache_miss."""
    manager, mock_redis = mock_callbacks_manager
    mock_context = MagicMock(spec=CallbackContext)
    mock_context.state = {"pending_cache_prompt": "test prompt"}
    
    mock_response = MagicMock(spec=LlmResponse)
    mock_response.content = types.Content(
        role="model", 
        parts=[types.Part.from_text(text="agent response")]
    )
    
    manager.handle_cache_miss(mock_context, mock_response)
    
    expected_key = manager._generate_cache_key("test prompt")
    mock_redis.set.assert_called_with(expected_key, "agent response")

def test_redis_fail_open_in_guardrail_with_cache_hit_function(mock_callbacks_manager):
    """Test that Redis errors do not block execution (fail open) in guardrail_with_cache_hit_function."""
    manager, mock_redis = mock_callbacks_manager
    mock_context = MagicMock(spec=CallbackContext)
    mock_context.state = {}
    
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [
        types.Content(role="user", parts=[types.Part.from_text(text="test prompt")])
    ]
    
    with patch("vague_descriptions_checker.utils.callbacks.genai.Client") as MockClient:
        mock_client_instance = MockClient.return_value
        mock_response = MagicMock()
        mock_response.text = "YES"
        mock_client_instance.models.generate_content.return_value = mock_response
        
        mock_redis.get.side_effect = Exception("Redis error")
        
        response = manager.guardrail_with_cache_hit_function(mock_context, mock_request)
        
        # Should return None (fail open) to proceed with normal LLM call
        assert response is None
