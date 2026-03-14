# Copyright 2025 Google LLC
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

from google.adk.agents import LlmAgent, BaseAgent
from google.adk.agents.callback_context import CallbackContext
from google.genai import types
from vague_descriptions_checker.utils.logging import get_logger
from vague_descriptions_checker.utils.prompt import SYSTEM_PROMPT
from vague_descriptions_checker.utils.web_fetch import fetch_cbp_content
from vague_descriptions_checker.utils.callbacks import CallbacksManager
import os
from pydantic import BaseModel, Field
from typing import Literal
# from google.adk.runners import InMemoryRunner
# import asyncio

# Initialize the logger for this module
logger = get_logger("vague_descriptions_checker.agent")

class VagueClassification(BaseModel):
    classification: Literal["CLEAR", "VAGUE"] = Field(description="The classification of the cargo description")
    reason: str = Field(description="Detailed explanation of classification grounded based on the CBP website information")

def create_vague_descriptions_checker_agent(name: str = "vague_descriptions_checker") -> BaseAgent:
    logger.info("Initializing CallbacksManager for agent", extra={"json_fields": {"agent_name": name}})
    callbacks_manager = CallbacksManager()
    
    logger.info("Creating LlmAgent instance", extra={
        "json_fields": {
            "model": os.getenv("GOOGLE_GENAI_MODEL", "gemini-2.5-flash"),
            "temperature": os.getenv("GOOGLE_GENAI_TEMPERATURE", 0.01)
        }
    })
    
    root_agent = LlmAgent(
        name="vague_descriptions_checker",  
        model=os.getenv("GOOGLE_GENAI_MODEL", "gemini-2.5-flash"),
        instruction=SYSTEM_PROMPT,
        tools=[fetch_cbp_content],
        output_schema=VagueClassification,
        generate_content_config=types.GenerateContentConfig(
            seed=os.getenv("GOOGLE_GENAI_SEED", 123),
            temperature=os.getenv("GOOGLE_GENAI_TEMPERATURE", 0.01),
            http_options=types.HttpOptions(
            retry_options=types.HttpRetryOptions(initial_delay=1, attempts=2),
            ),
        ),
        before_model_callback=callbacks_manager.guardrail_function,
        after_model_callback=callbacks_manager.handle_cache_miss,
    )

    return root_agent

root_agent = create_vague_descriptions_checker_agent()
logger.info("Vague Descriptions Checker Agent successfully created")
# async def main():
#     """Main entry point for the agent."""
#     prompt = 'hello world'
#     runner = InMemoryRunner(
#         agent=create_vague_descriptions_checker_agent(),
#         app_name='vague_descriptions_checker',
#     )

#     # The rest is the same as starting a regular ADK runner.
#     session = await runner.session_service.create_session(
#         user_id='user',
#         app_name='vague_descriptions_checker',
#     )

#     async for event in runner.run_async(
#         user_id='user',
#         session_id=session.id,
#         new_message=types.Content(
#             role='user', parts=[types.Part.from_text(text=prompt)]
#         )
#     ):
#         print(f'** Got event from {event.author}')
#         if event.content and event.content.parts:
#             print(f"Content: {event.content.parts[0].text}")

# if __name__ == "__main__":
#     asyncio.run(main())