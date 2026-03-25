import asyncio
import json
import os
import time
from typing import List, Dict, Any
from google.adk.runners import InMemoryRunner
from google.genai import types
from vague_descriptions_checker.agent import root_agent

# Simple .env loader to ensure environment variables are available
def load_dotenv(path: str = ".env"):
    if not os.path.exists(path):
        return
    with open(path) as f:
        for line in f:
            line = line.strip()
            if "=" in line and not line.startswith("#"):
                key, val = line.split("=", 1)
                # Remove quotes if present
                val = val.strip().strip('"').strip("'")
                os.environ[key] = val

async def run_classification(runner: InMemoryRunner, session_id: str, description: str) -> tuple[Dict[str, Any], float]:
    """Runs classification for a single description and returns the result and latency."""
    start_time = time.perf_counter()
    full_text = ""
    
    try:
        async for event in runner.run_async(
            user_id="metrics_user",
            session_id=session_id,
            new_message=types.Content(
                role="user",
                parts=[types.Part.from_text(text=description)]
            )
        ):
            if event.content and event.content.parts:
                for part in event.content.parts:
                    if part.text:
                        full_text += part.text
        
        end_time = time.perf_counter()
        latency = end_time - start_time
        
        # Parse JSON output from the agent
        # We look for the first JSON object in the text if it's not a pure JSON string
        try:
            # First try direct parse
            result = json.loads(full_text.strip())
        except json.JSONDecodeError:
            # If failed, look for JSON markers
            if "{" in full_text and "}" in full_text:
                start_idx = full_text.find("{")
                end_idx = full_text.rfind("}") + 1
                result = json.loads(full_text[start_idx:end_idx])
            else:
                raise ValueError(f"Could not find valid JSON in agent response: {full_text}")
                
        return result, latency
    except Exception as e:
        end_time = time.perf_counter()
        return {"classification": "ERROR", "reason": str(e)}, end_time - start_time

def calculate_metrics(results: List[Dict]):
    """Calculates accuracy and precision based on expected vs actual labels."""
    # Convert both to lowercase for comparison as requested
    y_true = [r["expected"].lower() for r in results if r["actual"] != "ERROR"]
    y_pred = [r["actual"].lower() for r in results if r["actual"] != "ERROR"]
    
    if not y_true:
        return 0.0, {}
    
    # Accuracy
    correct = sum(1 for t, p in zip(y_true, y_pred) if t == p)
    accuracy = correct / len(y_true)
    
    # Precision per class
    classes = sorted(list(set(y_true)))
    precision_scores = {}
    for cls in classes:
        # Precision = TP / (TP + FP)
        tp = sum(1 for t, p in zip(y_true, y_pred) if t == cls and p == cls)
        fp = sum(1 for t, p in zip(y_true, y_pred) if t != cls and p == cls)
        precision_scores[cls] = tp / (tp + fp) if (tp + fp) > 0 else 0.0
        
    return accuracy, precision_scores

async def main():
    load_dotenv()
    
    # Load test data
    test_data_path = "test_data.jsonl"
    if not os.path.exists(test_data_path):
        print(f"Error: {test_data_path} not found.")
        return
        
    test_data = []
    with open(test_data_path, "r") as f:
        for line in f:
            if line.strip():
                test_data.append(json.loads(line))
                
    if not test_data:
        print("Error: test_data.jsonl is empty.")
        return

    # Initialize Runner
    runner = InMemoryRunner(agent=root_agent, app_name="vague_descriptions_checker")
    session = await runner.session_service.create_session(
        user_id="metrics_user", 
        app_name="vague_descriptions_checker"
    )
    
    print(f"Loaded {len(test_data)} test cases.")
    print(f"Using model: {os.getenv('GOOGLE_GENAI_MODEL', 'gemini-2.5-flash')}")
    print("-" * 60)
    print(f"{'#':<3} | {'Description':<30} | {'Expected':<10} | {'Actual':<10} | {'Latency':<8}")
    print("-" * 60)
    
    results = []
    latencies = []
    
    for i, item in enumerate(test_data):
        desc = item.get("descriptions", "")
        expected = item.get("Label", "")
        
        agent_output, latency = await run_classification(runner, session.id, desc)
        actual = agent_output.get("classification", "ERROR")
        
        results.append({
            "description": desc,
            "expected": expected,
            "actual": actual,
            "latency": latency
        })
        
        if actual != "ERROR":
            latencies.append(latency)
        
        print(f"{i+1:<3} | {desc[:30]:<30} | {expected:<10} | {actual:<10} | {latency:>7.2f}s")

    # Final calculations
    accuracy, precision = calculate_metrics(results)
    errors = sum(1 for r in results if r["actual"] == "ERROR")
    
    print("-" * 60)
    print("FINAL RESULTS")
    print("-" * 60)
    print(f"Accuracy:           {accuracy:.2%}")
    for cls, score in precision.items():
        print(f"Precision ({cls:<6}): {score:.2%}")
    
    if latencies:
        avg_lat = sum(latencies) / len(latencies)
        print(f"Average Latency:    {avg_lat:.2f}s")
        print(f"Median Latency:     {sorted(latencies)[len(latencies)//2]:.2f}s")
        print(f"Min/Max Latency:    {min(latencies):.2f}s / {max(latencies):.2f}s")
    
    if errors > 0:
        print(f"Classification Errors: {errors}")
    print("-" * 60)

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\nEvaluation interrupted by user.")
    except Exception as e:
        print(f"\nAn error occurred: {e}")
