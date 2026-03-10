import pytest
import json
from unittest.mock import MagicMock, patch
import requests
from vague_descriptions_checker.utils.web_fetch import fetch_cbp_content

@pytest.fixture
def mock_env():
    with patch("os.getenv") as mock_get:
        def side_effect(key, default=None):
            if key == "CBP_URL":
                return "https://example.com"
            if key == "CBP_GCS_URL":
                return "gs://bucket/cbp_data.json"
            return default
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
        mock_fs.open.return_value.__enter__.return_value = mock_file
        
        content = fetch_cbp_content()
        
        assert content == "Some content"
        mock_requests_get.assert_called_once()
        mock_fs.open.assert_called_with("gs://bucket/cbp_data.json", 'w')
        # Check if json.dump was called on the mock_file
        # (Alternatively, we could use a real buffer if needed)

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
        mock_file.read.return_value = json.dumps({"content": "cached content"})
        mock_fs.open.return_value.__enter__.return_value = mock_file
        
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
