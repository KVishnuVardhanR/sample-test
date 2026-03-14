import os
import re
import html
import requests
import json
import gcsfs
from dotenv import load_dotenv
from vague_descriptions_checker.utils.logging import get_logger

logger = get_logger("web_fetch")

# Load environment variables from .env file
load_dotenv()

def clean_html(raw_html):
    """
    Cleans HTML content by stripping tags, unescaping entities, and normalizing whitespace.
    """
    # Remove script and style elements
    clean_text = re.sub(r'<(script|style)[^>]*>.*?</\1>', '', raw_html, flags=re.DOTALL | re.IGNORECASE)
    
    # Strip HTML tags
    clean_text = re.sub(r'<[^>]+>', ' ', clean_text)
    
    # Unescape HTML entities
    clean_text = html.unescape(clean_text)
    
    # Normalize whitespace
    clean_text = re.sub(r'\s+', ' ', clean_text).strip()
    
    return clean_text

def fetch_cbp_content():
    """
    Fetches the content of the CBP website defined in the CBP_URL environment variable.
    If fetching fails, it tries to load the content from the GCS URL defined in CBP_GCS_URL.
    If fetching is successful, it updates the GCS URL with the new content.
    Returns the cleaned text content.
    """
    url = os.getenv("CBP_URL")
    gcs_url = os.getenv("CBP_GCS_URL")
    
    if not url:
        logger.error("CBP_URL environment variable is not set")
        return None

    try:
        logger.info("Fetching content from CBP website", extra={"json_fields": {"url": url}})
        response = requests.get(url, timeout=10)
        response.raise_for_status()  # Check for HTTP errors
        content = clean_html(response.text)
        
        # Update GCS if possible
        if gcs_url:
            try:
                fs = gcsfs.GCSFileSystem()
                with fs.open(gcs_url, 'w') as f:
                    json.dump({"content": content}, f)
                logger.info("Successfully updated GCS cache", extra={"json_fields": {"gcs_url": gcs_url}})
            except Exception as e:
                logger.warning("Failed to update GCS cache", extra={"json_fields": {"gcs_url": gcs_url, "error": str(e)}})
        
        return content
        
    except requests.exceptions.RequestException as e:
        logger.error("CBP website fetch failed", extra={"json_fields": {"url": url, "error": str(e)}})
        logger.info("Attempting to fetch from GCS fallback")
        
        if not gcs_url:
            logger.error("CBP_GCS_URL is not set, no fallback available")
            return None
            
        try:
            fs = gcsfs.GCSFileSystem()
            if fs.exists(gcs_url):
                with fs.open(gcs_url, 'r') as f:
                    data = json.load(f)
                    logger.info("Successfully loaded content from GCS fallback", extra={"json_fields": {"gcs_url": gcs_url}})
                    return data.get("content")
            else:
                logger.error("GCS fallback file does not exist", extra={"json_fields": {"gcs_url": gcs_url}})
                return None
        except Exception as ge:
            logger.error("Error fetching from GCS fallback", extra={"json_fields": {"error": str(ge)}})
            return None