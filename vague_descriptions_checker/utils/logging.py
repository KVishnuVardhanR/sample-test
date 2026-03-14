import logging
import os
import google.cloud.logging
from google.cloud.logging.handlers import StructuredLogHandler

def setup_production_logging():
    """
    Sets up structured JSON logging for Google Cloud.
    If running locally, it can fall back to standard stream logging.
    """
    # 1. Initialize the Google Cloud Logging client
    try:
        client = google.cloud.logging.Client()
        # 2. Use StructuredLogHandler to send JSON to stdout
        # This is preferred for Cloud Run as it's non-blocking
        handler = StructuredLogHandler()
    except Exception:
        # Fallback for local development or when credentials are not available
        handler = logging.StreamHandler()
        formatter = logging.Formatter('%(levelname)s:%(name)s:%(message)s')
        handler.setFormatter(formatter)
    
    # 3. Configure the root logger
    root_logger = logging.getLogger()
    root_logger.setLevel(os.getenv("LOG_LEVEL", "INFO"))
    
    # Remove existing handlers to avoid duplicate logs
    for h in root_logger.handlers[:]:
        root_logger.removeHandler(h)
    
    root_logger.addHandler(handler)
    
    # 4. Specifically configure ADK loggers to be less verbose by default
    logging.getLogger("google_adk").setLevel(logging.INFO)

def get_logger(name: str):
    return logging.getLogger(name)
