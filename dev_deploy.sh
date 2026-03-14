#!/bin/bash
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


# Configuration
PROJECT_ID="chat-app-demo-459315"
REGION="us-central1"
SERVICE_NAME="vague-descriptions-checker-api"
IMAGE_NAME="gcr.io/${PROJECT_ID}/${SERVICE_NAME}"

# Ensure we are in the right project
echo "🎯 Setting project to ${PROJECT_ID}..."
gcloud config set project ${PROJECT_ID}

# Build the image using Cloud Build
echo "🚀 Building image ${IMAGE_NAME}..."
gcloud builds submit --tag ${IMAGE_NAME}

# Create a temporary env-vars.yaml from .env
# Cloud Run --env-vars-file expects a YAML format
# We wrap values in quotes to ensure numeric IDs are treated as strings
# Create a temporary env-vars.yaml from .env
echo "📝 Preparing environment variables..."
if [ -f .env ]; then
    # 1. Strip comments and empty lines
    # 2. Convert 'KEY=VALUE' to 'KEY: "VALUE"'
    grep -v '^#' .env | grep -v '^[[:space:]]*$' | \
    sed 's/ *= */: /' | \
    sed 's/: \(.*\)/: "\1"/' | \
    sed 's/""/"/g' > env-vars.yaml
    
    # ADD THIS LINE: Inject the LOG_LEVEL into the YAML file
    echo "LOG_LEVEL: \"DEBUG\"" >> env-vars.yaml
else
    echo "LOG_LEVEL: \"DEBUG\"" > env-vars.yaml
fi

# Deploy to Cloud Run
echo "🚢 Deploying to Cloud Run..."
gcloud run deploy ${SERVICE_NAME} \
    --image ${IMAGE_NAME} \
    --region ${REGION} \
    --platform managed \
    --allow-unauthenticated \
    --env-vars-file env-vars.yaml \
    --vpc-connector="vpc-conn" \
    --vpc-egress="private-ranges-only"

# Cleanup
rm env-vars.yaml

echo "✅ Deployment complete!"
URL=$(gcloud run services describe ${SERVICE_NAME} --region ${REGION} --format 'value(status.url)')
echo "🔗 Service URL: ${URL}"
