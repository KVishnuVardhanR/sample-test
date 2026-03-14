from google import genai
from google.adk.agents.callback_context import CallbackContext
from google.genai import types
from google.adk.agents.base_agent import BaseAgent
from google.adk.models import LlmResponse, LlmRequest
import os
import json
from typing import Optional


import redis

class CallbacksManager:
    def __init__(self):
        self.host = os.environ.get("REDIS_HOST", "10.59.0.3")
        self.port = int(os.environ.get("REDIS_PORT", 6379))
        self.client = redis.Redis(
            host=self.host, 
            port=self.port, 
            decode_responses=True,
            socket_timeout=5,
            socket_connect_timeout=5
        )

    def guardrail_function(self, callback_context: CallbackContext, llm_request: LlmRequest) -> Optional[LlmResponse]:
        """
        Guardrail to ensure the user input is a cargo description using an LLM as a judge.
        Also checks Redis cache if input is a cargo description.
        """
        last_user_message = ""
        if llm_request.contents and llm_request.contents[-1].role == 'user':
            if llm_request.contents[-1].parts:
                last_user_message = llm_request.contents[-1].parts[0].text or ""

        if not last_user_message.strip():
            return None

        callback_context.state["pending_cache_prompt"] = last_user_message.strip()
        # 1. Check if the input is a cargo description using an LLM as judge
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
            
            # 2. If it is a cargo description, check Redis cache
            try:
                cached_response = self.client.get(last_user_message)
                if cached_response:
                    print(f"⚡ [CACHE HIT] Found existing response for: '{last_user_message.strip()[:30]}...'")
                    return LlmResponse(
                        content=types.Content(
                            role="model",
                            parts=[types.Part(text=cached_response)]
                        )
                    )
            except Exception as e:
                print(f"Error checking Redis cache: {e}")
                # Proceed to LLM call if Redis fails
                
        except Exception as e:
            print(f"Error in guardrail judge: {e}")
            # In case of error, we proceed with the normal call as a fallback
            return None
        
        return None

    def handle_cache_miss(self, callback_context: CallbackContext, llm_response: LlmResponse) -> None:
        """
        Update Redis cache with the agent's response after an LLM call.
        """
        prompt = callback_context.state.get("pending_cache_prompt")
        
        if not prompt or not llm_response.content or not llm_response.content.parts:
            return None

        try:
            agent_response = llm_response.content.parts[0].text
            if agent_response:
                # Cache the response with the user message as the key
                self.client.set(prompt, agent_response)
        except Exception as e:
            print(f"Error updating Redis cache: {e}")
            
        return None