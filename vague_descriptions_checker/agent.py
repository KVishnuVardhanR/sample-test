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
from google.adk.models import LlmResponse, LlmRequest
from google.adk.tools.url_context_tool import url_context
from .utils.prompt import SYSTEM_PROMPT
from .utils.web_fetch import fetch_cbp_content
# from .utils.guardrails import guardrail_function
import os
import json
from pydantic import BaseModel, Field
from typing import Literal, Optional

class VagueClassification(BaseModel):
    classification: Literal["CLEAR", "VAGUE"] = Field(description="The classification of the cargo description")
    reason: str = Field(description="Detailed explanation of classification grounded based on the CBP website information")

def create_vague_descriptions_checker_agent(name: str = "vague_descriptions_checker") -> BaseAgent:
    root_agent = LlmAgent(
    name="vague_descriptions_checker",  
    model=os.getenv("GOOGLE_GENAI_MODEL"),
    instruction=SYSTEM_PROMPT,
    tools=[fetch_cbp_content],
    output_schema=VagueClassification,
    generate_content_config=types.GenerateContentConfig(
        seed=os.getenv("GOOGLE_GENAI_SEED"),
        temperature=os.getenv("GOOGLE_GENAI_TEMPERATURE"),
    ),
        # before_model_callback=guardrail_function,
    )

    return root_agent