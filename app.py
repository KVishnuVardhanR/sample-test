# deploy_fast_api_app.py

import os
import redis
from google.adk.cli.fast_api import get_fast_api_app
from fastapi import FastAPI
from vague_descriptions_checker.utils.logging import setup_production_logging, get_logger

# Initialize structured logging first
setup_production_logging()
logger = get_logger("app_entry")

# Set GOOGLE_CLOUD_PROJECT environment variable for cloud tracing
os.getenv("GOOGLE_CLOUD_PROJECT")

# Discover the `weather_agent` directory in current working dir
AGENT_DIR = "vague_descriptions_checker"

# Create FastAPI app with enabled cloud tracing
app: FastAPI = get_fast_api_app(
    agents_dir=AGENT_DIR,
    web=False,
    trace_to_cloud=True,
    otel_to_cloud=True,
)

logger.info("Starting Vague Descriptions Checker API on Cloud Run")

app.title = "vague_descriptions_checker"
app.description = "API for interacting with the Agent vague_descriptions_checker"


# Health check endpoints
@app.get("/health", tags=["Health"])
async def liveness_check():
    """Liveness probe: returns 200 if the process is running."""
    return {"status": "ok"}

@app.get("/ready", tags=["Health"])
async def readiness_check():
    """Readiness probe: verifies Redis connectivity before serving traffic."""
    try:
        # Initialize Redis client for health checks
        redis_client = redis.Redis(
            host=os.environ.get("REDIS_HOST", "10.59.0.3"),
            port=int(os.environ.get("REDIS_PORT", 6379)),
            socket_timeout=5,
            socket_connect_timeout=5
        )
        if redis_client.ping():
            return {"status": "ready", "cache": "connected"}
    except Exception as e:
        logger.error(f"Readiness check failed: Redis unreachable at {redis_client.connection_pool.connection_kwargs['host']}")
        raise HTTPException(status_code=503, detail="Redis connection failed")


# Main execution
if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8080)