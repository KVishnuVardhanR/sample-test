# deploy_fast_api_app.py

import os
from google.adk.cli.fast_api import get_fast_api_app
from fastapi import FastAPI

# Set GOOGLE_CLOUD_PROJECT environment variable for cloud tracing
os.getenv("GOOGLE_CLOUD_PROJECT")

# Discover the `weather_agent` directory in current working dir
AGENT_DIR = "vague_descriptions_checker"

# Create FastAPI app with enabled cloud tracing
app: FastAPI = get_fast_api_app(
    agents_dir=AGENT_DIR,
    web=True,
    trace_to_cloud=True,
    otel_to_cloud=True,
)

app.title = "vague_descriptions_checker"
app.description = "API for interacting with the Agent vague_descriptions_checker"


# Main execution
if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8080)