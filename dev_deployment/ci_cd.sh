# Create the deployment service account
gcloud iam service-accounts create github-deployer \
  --display-name="GitHub Actions Deployer" \
  --description="Used by GitHub Actions to deploy to Cloud Run"

# Create the Artifact Registry repository
gcloud artifacts repositories create cloud-run-images \
  --repository-format=docker \
  --location=us-central1

# Store the full email for later use
SA_EMAIL="github-deployer@$(gcloud config get-value project).iam.gserviceaccount.com"

# Grant Cloud Run Admin role
gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/run.admin"

# Grant Artifact Registry Writer role
gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/artifactregistry.writer"

# Grant Service Account User role (needed to deploy Cloud Run services)
gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/iam.serviceAccountUser"

# Grant Cloud Build Editor role (if using Cloud Build)
gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/cloudbuild.builds.editor"

  # Create the Workload Identity Pool
gcloud iam workload-identity-pools create github-pool \
  --location="global" \
  --display-name="GitHub Actions Pool" \
  --description="Pool for GitHub Actions OIDC authentication"

  # Create the OIDC provider for GitHub
gcloud iam workload-identity-pools providers create-oidc github-provider \
  --location="global" \
  --workload-identity-pool="github-pool" \
  --display-name="GitHub OIDC Provider" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository,attribute.actor=assertion.actor" \
  --attribute-condition="assertion.repository=='KVishnuVardhanR/sample-test'"

  # Get the Workload Identity Pool ID
POOL_ID=$(gcloud iam workload-identity-pools describe github-pool \
  --location="global" \
  --format="value(name)")

# Allow the GitHub provider to impersonate the service account
gcloud iam service-accounts add-iam-policy-binding ${SA_EMAIL} \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/${POOL_ID}/attribute.repository/KVishnuVardhanR/sample-test"

  # Get the full provider resource name
gcloud iam workload-identity-pools providers describe github-provider \
  --location="global" \
  --workload-identity-pool="github-pool" \
  --format="value(name)"