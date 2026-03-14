# Copyright 2026 Google LLC
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

import pytest
import json
from unittest.mock import MagicMock, patch
import requests
import os
from vague_descriptions_checker.utils.web_fetch import fetch_cbp_content

@pytest.fixture
def mock_env():
    """Fixture to mock environment variables."""
    # Ensure REDIS_HOST is set to localhost as requested by user
    os.environ["REDIS_HOST"] = "localhost"
    
    with patch("os.getenv") as mock_get:
        def side_effect(key, default=None):
            if key == "CBP_URL":
                return "https://example.com"
            if key == "CBP_GCS_URL":
                return "gs://bucket/cbp_data.json"
            if key == "REDIS_HOST":
                return "localhost"
            return os.environ.get(key, default)
        mock_get.side_effect = side_effect
        yield mock_get

def test_fetch_cbp_content_success(mock_env):
    """Test successful website fetch and GCS update."""
    with patch("requests.get") as mock_requests_get, \
         patch("gcsfs.GCSFileSystem") as MockGCS:
        
        # Mock requests
        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.text = "<html><body>Some content</body></html>"
        mock_requests_get.return_value = mock_response
        
        # Mock GCS
        mock_fs = MockGCS.return_value
        mock_file = MagicMock()
        mock_file.__enter__.return_value = mock_file # Support CM
        mock_fs.open.return_value = mock_file
        
        content = fetch_cbp_content()
        
        assert content == "Some content"
        mock_requests_get.assert_called_once()
        mock_fs.open.assert_called_with("gs://bucket/cbp_data.json", 'w')

def test_fetch_cbp_content_fallback(mock_env):
    """Test website fetch failure and GCS fallback."""
    with patch("requests.get") as mock_requests_get, \
         patch("gcsfs.GCSFileSystem") as MockGCS:
        
        # Mock requests failure
        mock_requests_get.side_effect = requests.exceptions.RequestException("Down")
        
        # Mock GCS fallback
        mock_fs = MockGCS.return_value
        mock_fs.exists.return_value = True
        mock_file = MagicMock()
        mock_file.__enter__.return_value = mock_file
        mock_fs.open.return_value = mock_file
        
        # We need to mock json.load as well if it's used with the mock_file
        with patch("json.load") as mock_json_load:
            mock_json_load.return_value = {"content": "cached content"}
            content = fetch_cbp_content()
            
            assert content == "cached content"
            mock_requests_get.assert_called_once()
            mock_fs.exists.assert_called_with("gs://bucket/cbp_data.json")
            mock_fs.open.assert_called_with("gs://bucket/cbp_data.json", 'r')

def test_fetch_cbp_content_total_failure(mock_env):
    """Test both website and GCS failure."""
    with patch("requests.get") as mock_requests_get, \
         patch("gcsfs.GCSFileSystem") as MockGCS:
        
        # Mock requests failure
        mock_requests_get.side_effect = requests.exceptions.RequestException("Down")
        
        # Mock GCS miss
        mock_fs = MockGCS.return_value
        mock_fs.exists.return_value = False
        
        content = fetch_cbp_content()
        
        assert content is None
