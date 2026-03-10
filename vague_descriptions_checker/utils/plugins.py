from google import genai
from google.adk.agents.callback_context import CallbackContext
from google.genai import types
from google.adk.models import LlmResponse, LlmRequest
from google.adk.plugins.base_plugin import BasePlugin
import os
import json
import redis
from typing import Optional

class RedisPlugin(BasePlugin):
    def __init__(self, name: str = "redis_plugin"):
        super().__init__(name=name)
        self.host = os.environ.get("REDIS_HOST", "localhost")
        self.port = int(os.environ.get("REDIS_PORT", 6379))
        self.client = redis.Redis(
            host=self.host, 
            port=self.port, 
            decode_responses=True,
            socket_timeout=5,
            socket_connect_timeout=5
        )

    def before_model_callback(self, callback_context: CallbackContext, llm_request: LlmRequest) -> Optional[LlmResponse]:
        """
        Check Redis cache for a response to the user's prompt.
        """
        last_user_message = ""
        if llm_request.contents and llm_request.contents[-1].role == 'user':
            if llm_request.contents[-1].parts:
                last_user_message = llm_request.contents[-1].parts[0].text or ""

        if not last_user_message.strip():
            return None

        try:
            cached_response = self.client.get(last_user_message)
            if cached_response:
                return LlmResponse(
                    content=types.Content(
                        role="model",
                        parts=[types.Part(text=cached_response)]
                    )
                )
        except Exception as e:
            print(f"Error checking Redis cache: {e}")
            return None
        
        return None

    def after_agent_callback(self, callback_context: CallbackContext, llm_request: LlmRequest, llm_response: LlmResponse):
        """
        Update Redis cache with the agent's response.
        """
        last_user_message = ""
        if llm_request.contents and llm_request.contents[-1].role == 'user':
            if llm_request.contents[-1].parts:
                last_user_message = llm_request.contents[-1].parts[0].text or ""

        if not last_user_message.strip() or not llm_response.content.parts:
            return

        try:
            agent_response = llm_response.content.parts[0].text
            if agent_response:
                # Cache the response with the user message as the key
                self.client.set(last_user_message, agent_response)
        except Exception as e:
            print(f"Error updating Redis cache: {e}")

class GuardrailPlugin(BasePlugin):
    def __init__(self, name: str = "guardrail_plugin"):
        super().__init__(name=name)

    def before_agent_callback(self, callback_context: CallbackContext, llm_request: LlmRequest) -> Optional[LlmResponse]:
        """
        Guardrail to ensure the user input is a cargo description using an LLM as a judge.
        """
        last_user_message = ""
        if llm_request.contents and llm_request.contents[-1].role == 'user':
            if llm_request.contents[-1].parts:
                last_user_message = llm_request.contents[-1].parts[0].text or ""

        if not last_user_message.strip():
            return None

        # Use the GenAI client to judge the input
        client = genai.Client(
            vertexai=(os.getenv("GOOGLE_GENAI_USE_VERTEXAI", "TRUE").upper() == "TRUE"),
            project=os.getenv("GOOGLE_CLOUD_PROJECT"),
            location=os.getenv("GOOGLE_CLOUD_LOCATION")
        )
        
        judge_prompt = f"""
        You are a classifier judging if a user input is a cargo description (e.g., 'parts', 'electronics', 'Men's cotton t-shirts', 'stuff', 'FAK') or if it is something else (e.g., a greeting, a joke, a general question).
        
        Identify if the following text is a cargo description or a request to classify one.
        Respond with exactly 'YES' if it is a cargo description, and 'NO' if it is anything else.
        
        Input: "{last_user_message}"
        
        Response (YES/NO):"""

        try:
            response = client.models.generate_content(
                model=os.getenv("GOOGLE_GENAI_MODEL"),
                contents=judge_prompt,
                config=types.GenerateContentConfig(
                    temperature=0.0,
                    max_output_tokens=3
                )
            )
            
            if response.text and "NO" in response.text.upper():
                # The user input is not a cargo description
                response_data = {
                    "reason": "The provided input does not appear to be a cargo description. Please provide a cargo description (e.g., 'Men's cotton t-shirts' or 'Electronics') for analysis."
                }
                return LlmResponse(
                    content=types.Content(
                        role="model",
                        parts=[types.Part(text=json.dumps(response_data))]
                    )
                )
                
        except Exception as e:
            print(f"Error in guardrail judge: {e}")
            # In case of error, we proceed with the normal call as a fallback
            return None
        
        return None

