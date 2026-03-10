import os
import re
import html
import requests
import json
import gcsfs
from dotenv import load_dotenv

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
        print("Error: CBP_URL environment variable is not set.")
        return None

    try:
        print(f"Fetching content from {url}...")
        response = requests.get(url, timeout=10)
        response.raise_for_status()  # Check for HTTP errors
        content = clean_html(response.text)
        
        # Update GCS if possible
        if gcs_url:
            try:
                fs = gcsfs.GCSFileSystem()
                with fs.open(gcs_url, 'w') as f:
                    json.dump({"content": content}, f)
                print(f"Successfully updated GCS at {gcs_url}")
            except Exception as e:
                print(f"Warning: Failed to update GCS at {gcs_url}: {e}")
        
        return content
        
    except requests.exceptions.RequestException as e:
        print(f"Error fetching content from {url}: {e}")
        print("Website might be down. Attempting to fetch from GCS...")
        
        if not gcs_url:
            print("Error: CBP_GCS_URL is not set, no fallback available.")
            return None
            
        try:
            fs = gcsfs.GCSFileSystem()
            if fs.exists(gcs_url):
                with fs.open(gcs_url, 'r') as f:
                    data = json.load(f)
                    print(f"Successfully loaded content from GCS: {gcs_url}")
                    return data.get("content")
            else:
                print(f"Error: GCS file {gcs_url} does not exist.")
                print("Note: GCS fallback requires a successful website fetch at least once to populate the cache.")
                return None
        except Exception as ge:
            print(f"Error fetching from GCS fallback: {ge}")
            return None