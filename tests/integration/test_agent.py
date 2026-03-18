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
import os
import pytest_asyncio
from google.adk.runners import InMemoryRunner
from google.genai import types
from unittest.mock import MagicMock, patch, AsyncMock

from vague_descriptions_checker.agent import create_vague_descriptions_checker_agent
from vague_descriptions_checker.utils.callbacks import CallbacksManager

@pytest_asyncio.fixture
async def agent_setup():
    """Fixture to set up the InMemoryRunner and mocks."""
    os.environ["REDIS_HOST"] = "localhost"
    
    # Patch genai.Client and redis.Redis
    with patch("google.genai.Client") as MockClient, \
         patch("vague_descriptions_checker.utils.callbacks.redis.Redis") as MockRedis:
        
        mock_client = MockClient.return_value
        mock_redis = MockRedis.return_value
        
        # Ensure the client is awaitable where needed
        mock_client.aio.models.generate_content = AsyncMock()
        
        runner = InMemoryRunner(
            agent=create_vague_descriptions_checker_agent(),
            app_name='vague_descriptions_checker',
        )
        
        session = await runner.session_service.create_session(
            user_id='test_user',
            app_name='vague_descriptions_checker',
        )
        
        yield runner, session.id, mock_client, mock_redis

async def run_agent_query(runner, session_id, prompt):
    """Helper to run a query and collect the final response text."""
    final_text = ""
    async for event in runner.run_async(
        user_id='test_user',
        session_id=session_id,
        new_message=types.Content(
            role='user', parts=[types.Part.from_text(text=prompt)]
        )
    ):
        if event.content and event.content.parts:
            final_text += event.content.parts[0].text
    
    try:
        return json.loads(final_text)
    except json.JSONDecodeError:
        return final_text

def create_mock_response(text: str) -> types.GenerateContentResponse:
    """Helper to create a valid GenerateContentResponse."""
    return types.GenerateContentResponse(
        candidates=[
            types.Candidate(
                content=types.Content(
                    role="model",
                    parts=[types.Part(text=text)]
                ),
                finish_reason=types.FinishReason.STOP
            )
        ],
        usage_metadata=types.UsageMetadata(
            prompt_token_count=10, 
            response_token_count=10, 
            total_token_count=20
        ),
        model_version="gemini-2.0-flash"
    )

@pytest.mark.asyncio
async def test_agent_clear_description(agent_setup) -> None:
    """Tests that a clear cargo description is classified correctly."""
    runner, session_id, mock_client, mock_redis = agent_setup
    
    # Mock Guardrail (Judge says YES)
    mock_client.models.generate_content.return_value = create_mock_response("YES")
    
    # Mock Redis cache miss
    mock_redis.get.return_value = None
    
    # Mock Agent Model Response (Async)
    agent_text = json.dumps({
        "classification": "CLEAR",
        "reason": "The description 'Men's cotton t-shirts' is specific."
    })
    mock_client.aio.models.generate_content.return_value = create_mock_response(agent_text)
    
    response = await run_agent_query(runner, session_id, "Men's cotton t-shirts")
    
    assert response["classification"] == "CLEAR"
    assert "reason" in response

@pytest.mark.asyncio
async def test_agent_vague_description(agent_setup) -> None:
    """Tests that a vague cargo description is classified correctly."""
    runner, session_id, mock_client, mock_redis = agent_setup
    
    # Mock Guardrail
    mock_client.models.generate_content.return_value = create_mock_response("YES")
    
    # Mock Redis MISS
    mock_redis.get.return_value = None
    
    # Mock Agent Model Response (Async)
    agent_text = json.dumps({
        "classification": "VAGUE",
        "reason": "The description 'Electronics' is too generic."
    })
    mock_client.aio.models.generate_content.return_value = create_mock_response(agent_text)
    
    response = await run_agent_query(runner, session_id, "Electronics")
    
    assert response["classification"] == "VAGUE"
    assert "reason" in response

@pytest.mark.asyncio
async def test_agent_guardrail_blocks_joke(agent_setup) -> None:
    """Tests that the guardrail blocks non-cargo input."""
    runner, session_id, mock_client, mock_redis = agent_setup
    
    # Mock Guardrail (Judge says NO)
    mock_client.models.generate_content.return_value = create_mock_response("NO")
    
    response = await run_agent_query(runner, session_id, "Tell me a joke")
    
    assert "not appear to be a cargo description" in response["reason"]

@pytest.mark.asyncio
async def test_agent_cache_hit(agent_setup) -> None:
    """Tests that the agent returns cached response from guardrail if available."""
    runner, session_id, mock_client, mock_redis = agent_setup
    
    # Mock Guardrail Judge says YES
    mock_client.models.generate_content.return_value = create_mock_response("YES")
    
    # Mock Redis HIT
    cached_response = json.dumps({
        "classification": "VAGUE",
        "reason": "Cached result for Parts"
    })
    mock_redis.get.return_value = cached_response
    
    response = await run_agent_query(runner, session_id, "Parts")
    
    assert response["classification"] == "VAGUE"
    assert "Cached" in response["reason"]
    
    # Generate the expected key using the same logic
    manager = CallbacksManager()
    expected_key = manager._generate_cache_key("Parts")
    mock_redis.get.assert_called_with(expected_key)
