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

import json
from unittest.mock import MagicMock, patch

from google.adk.agents.callback_context import CallbackContext
from google.adk.models import LlmRequest
from google.genai import types

from vague_descriptions_checker.utils.plugins import GuardrailPlugin


def test_guardrail_blocked_input() -> None:
    """Tests that the guardrail blocks non-cargo input."""
    
    mock_context = MagicMock(spec=CallbackContext)
    
    # Create an LlmRequest with a non-cargo message
    user_message = types.Content(
        role="user", 
        parts=[types.Part.from_text(text="Can you tell me a joke?")]
    )
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [user_message]
    
    # Mock the Gemini client to return "NO"
    with patch("vague_descriptions_checker.utils.plugins.genai.Client") as MockClient:
        mock_client_instance = MockClient.return_value
        mock_response = MagicMock()
        mock_response.text = "NO"
        mock_client_instance.models.generate_content.return_value = mock_response
        
        response = GuardrailPlugin().before_agent_callback(mock_context, mock_request)
        
        assert response is not None
        assert response.content.role == "model"
        
        # Verify response text contains the refusal message
        response_text = response.content.parts[0].text
        response_data = json.loads(response_text)
        assert "not appear to be a cargo description" in response_data["reason"]


def test_guardrail_allowed_input() -> None:
    """Tests that the guardrail allows valid cargo descriptions."""
    
    mock_context = MagicMock(spec=CallbackContext)
    
    # Create an LlmRequest with a valid cargo description
    user_message = types.Content(
        role="user", 
        parts=[types.Part.from_text(text="50 boxes of automotive parts")]
    )
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [user_message]
    
    # Mock the Gemini client to return "YES"
    with patch("vague_descriptions_checker.utils.plugins.genai.Client") as MockClient:
        mock_client_instance = MockClient.return_value
        mock_response = MagicMock()
        mock_response.text = "YES"
        mock_client_instance.models.generate_content.return_value = mock_response
        
        response = GuardrailPlugin().before_agent_callback(mock_context, mock_request)
        
        # Guardrail should return None to let the original call proceed
        assert response is None


def test_guardrail_exception_fail_open() -> None:
    """Tests that the guardrail fails open if the judge call errors."""
    
    mock_context = MagicMock(spec=CallbackContext)
    user_message = types.Content(
        role="user", 
        parts=[types.Part.from_text(text="Electronics")]
    )
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [user_message]
    
    # Mock the Gemini client to raise an exception
    with patch("vague_descriptions_checker.utils.plugins.genai.Client") as MockClient:
        mock_client_instance = MockClient.return_value
        mock_client_instance.models.generate_content.side_effect = Exception("API Error")
        
        response = GuardrailPlugin().before_agent_callback(mock_context, mock_request)
        
        # Should return None (fail open) on exception
        assert response is None
