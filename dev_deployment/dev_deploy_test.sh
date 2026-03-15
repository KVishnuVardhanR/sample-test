#!/bin/bash

# --- Configuration ---
SERVER_BASE_URL="https://vague-descriptions-checker-api-781395648013.us-central1.run.app"
APP_NAME="vague_descriptions_checker"
USER_ID="abc123"
# ---------------------

# 1. Generate a random UUID for the session ID
SESSION_ID=$(uuidgen)
echo "Generated Session ID: $SESSION_ID"

# 2. First API Call: POST /apps/{app_name}/users/{user_id}/sessions/{session_id}
echo -e "\n--- Starting First API Call (Session Creation) ---"
FIRST_URL="$SERVER_BASE_URL/apps/$APP_NAME/users/$USER_ID/sessions/$SESSION_ID"

# Send a POST request with an empty body (or adjust if your endpoint expects a payload)
curl -X POST \
  -H "Content-Type: application/json" \
  "$FIRST_URL"

echo -e "\n--- First API Call Complete ---\n"

# 3. Second API Call: POST RUN with a payload
echo "--- Starting Second API Call (RUN Endpoint) ---"
SECOND_URL="$SERVER_BASE_URL/run_sse"

# Construct the JSON payload using the generated SESSION_ID
PAYLOAD=$(cat <<EOF
{
  "appName": "$APP_NAME",
  "userId": "$USER_ID",
  "sessionId": "$SESSION_ID",
  "newMessage": {
    "parts": [
      {
        "text": "Macbook 13 inch Pro"
      }
    ],
    "role": "user"
  },
  "streaming": false
}
EOF
)

# Send the POST request with the JSON payload
curl -X POST \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" \
  "$SECOND_URL"

echo -e "\n--- Second API Call Complete ---"