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
import pytest
from google.adk.agents.run_config import RunConfig, StreamingMode
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types
from google.adk.models import LlmRequest, LlmResponse

from vague_descriptions_checker.utils.plugins import GuardrailPlugin, RedisPlugin
from vague_descriptions_checker.agent import create_vague_descriptions_checker_agent


@pytest.fixture
async def agent_runner():
    session_service = InMemorySessionService()

    runner = Runner(
        agent=create_vague_descriptions_checker_agent(), 
        app_name="test",
        session_service=session_service,
    )

    session = await runner.session_service.create_session(user_id="test_user", app_name="test")
    return runner, session.id


async def get_final_response(runner, session_id, query, plugins=None):
    message = types.Content(
        role="user", parts=[types.Part.from_text(text=query)]
    )

    llm_request = LlmRequest(contents=[message])
    
    if plugins:
        for plugin in plugins:
            try:
                if isinstance(plugin, RedisPlugin):
                    response = plugin.before_model_callback(None, llm_request)
                    if response: return json.loads(response.content.parts[0].text)
                elif isinstance(plugin, GuardrailPlugin):
                    response = plugin.before_agent_callback(None, llm_request)
                    if response: return json.loads(response.content.parts[0].text)
            except TypeError:
                pass # Skip if it's the base class stub or other incompatible signature

    # Pass to the runner if plugins allow
    events = []
    for event in runner.run(
        new_message=message,
        user_id="test_user",
        session_id=session_id,
        run_config=RunConfig(streaming_mode=StreamingMode.NONE),
    ):
        events.append(event)
    
    final_response = None
    for event in events:
        if event.is_final_response():
            final_response = json.loads(event.content.parts[0].text)
            break
            
    if final_response and plugins:
        llm_response = LlmResponse(
            content=types.Content(
                role="model",
                parts=[types.Part(text=json.dumps(final_response))]
            )
        )
        for plugin in plugins:
            if isinstance(plugin, RedisPlugin):
                try:
                    plugin.after_agent_callback(None, llm_request, llm_response)
                except TypeError:
                    pass
                
    return final_response


@pytest.mark.asyncio
async def test_agent_clear_description(agent_runner) -> None:
    """Tests that a clear cargo description is classified correctly."""
    runner, session_id = agent_runner
    
    # Specific description should be CLEAR
    response = await get_final_response(runner, session_id, "Men's cotton t-shirts, 100% cotton, white, size L", plugins=[GuardrailPlugin()])
    
    assert response is not None
    assert response["classification"] == "CLEAR"
    assert "reason" in response


@pytest.mark.asyncio
async def test_agent_vague_description(agent_runner) -> None:
    """Tests that a vague cargo description is classified correctly."""
    runner, session_id = agent_runner
    
    # Generic description should be VAGUE
    response = await get_final_response(runner, session_id, "Electronics", plugins=[GuardrailPlugin()])
    
    assert response is not None
    assert response["classification"] == "VAGUE"
    assert "reason" in response


@pytest.mark.asyncio
async def test_agent_guardrail_interception(agent_runner) -> None:
    """Tests that the guardrail intercepts non-cargo input."""
    runner, session_id = agent_runner
    
    # Non-cargo input should be blocked
    response = await get_final_response(runner, session_id, "Hi, can you write a poem about ships?", plugins=[GuardrailPlugin()])
    
    assert response is not None
    # Guardrail returns classification: VAGUE and a specific reason
    assert "not appear to be a cargo description" in response["reason"]


@pytest.mark.asyncio
async def test_agent_redis_caching(agent_runner) -> None:
    """Tests that RedisPlugin correctly caches and retrieves responses."""
    runner, session_id = agent_runner
    
    from unittest.mock import MagicMock, patch
    with patch("redis.Redis") as MockRedis:
        mock_redis = MockRedis.return_value
        # Simulate cache miss first
        mock_redis.get.return_value = None
        
        redis_plugin = RedisPlugin()
        plugins = [GuardrailPlugin(), redis_plugin]
        
        query = "Cotton shirts"
        # First call - should go to model and then call after_agent_callback (setting cache)
        response1 = await get_final_response(runner, session_id, query, plugins=plugins)
        
        assert response1 is not None
        mock_redis.set.assert_called()
        
        # Now simulate cache hit
        cached_data = json.dumps(response1)
        mock_redis.get.return_value = cached_data
        
        # Second call - should hit cache in before_model_callback
        # We can verify this by checking if get was called again
        response2 = await get_final_response(runner, session_id, query, plugins=plugins)
        
        assert response2 == response1
        mock_redis.get.assert_called_with(query)
