import json
import pytest
from unittest.mock import MagicMock, patch
from google.adk.agents.callback_context import CallbackContext
from google.adk.models import LlmRequest, LlmResponse
from google.genai import types

from vague_descriptions_checker.utils.plugins import RedisPlugin

@pytest.fixture
def mock_redis():
    with patch("redis.Redis") as MockRedis:
        mock_client = MockRedis.return_value
        yield mock_client

@pytest.fixture
def redis_plugin(mock_redis):
    return RedisPlugin()

def test_redis_plugin_before_model_callback_hit(redis_plugin, mock_redis):
    """Test cache hit in before_model_callback."""
    mock_context = MagicMock(spec=CallbackContext)
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [
        types.Content(role="user", parts=[types.Part.from_text(text="test prompt")])
    ]
    
    mock_redis.get.return_value = "cached response"
    
    response = redis_plugin.before_model_callback(mock_context, mock_request)
    
    assert response is not None
    assert response.content.parts[0].text == "cached response"
    mock_redis.get.assert_called_with("test prompt")

def test_redis_plugin_before_model_callback_miss(redis_plugin, mock_redis):
    """Test cache miss in before_model_callback."""
    mock_context = MagicMock(spec=CallbackContext)
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [
        types.Content(role="user", parts=[types.Part.from_text(text="new prompt")])
    ]
    
    mock_redis.get.return_value = None
    
    response = redis_plugin.before_model_callback(mock_context, mock_request)
    
    assert response is None
    mock_redis.get.assert_called_with("new prompt")

def test_redis_plugin_after_agent_callback(redis_plugin, mock_redis):
    """Test storage in after_agent_callback."""
    mock_context = MagicMock(spec=CallbackContext)
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [
        types.Content(role="user", parts=[types.Part.from_text(text="test prompt")])
    ]
    
    mock_response = MagicMock(spec=LlmResponse)
    mock_response.content = types.Content(
        role="model", 
        parts=[types.Part.from_text(text="agent response")]
    )
    
    redis_plugin.after_agent_callback(mock_context, mock_request, mock_response)
    
    mock_redis.set.assert_called_with("test prompt", "agent response")

def test_redis_plugin_fail_open_on_error(redis_plugin, mock_redis):
    """Test that Redis errors do not block execution (fail open)."""
    mock_context = MagicMock(spec=CallbackContext)
    mock_request = MagicMock(spec=LlmRequest)
    mock_request.contents = [
        types.Content(role="user", parts=[types.Part.from_text(text="test prompt")])
    ]
    
    mock_redis.get.side_effect = Exception("Redis error")
    
    response = redis_plugin.before_model_callback(mock_context, mock_request)
    
    assert response is None
