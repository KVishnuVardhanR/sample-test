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

resource "google_kms_key_ring" "keyring" {
  for_each = local.deploy_project_ids
  name     = local.kms_keyring_name
  location = var.region
  project  = each.value

  depends_on = [google_project_service.deploy_project_services]
}

resource "google_kms_crypto_key" "key" {
  for_each        = local.deploy_project_ids
  name            = local.kms_key_name
  key_ring        = google_kms_key_ring.keyring[each.key].id
  rotation_period = "7776000s" # 90 days

  lifecycle {
    prevent_destroy = false
  }
}

# Grant Artifact Registry service agent permission to use the key
resource "google_kms_crypto_key_iam_member" "ar_kms" {
  for_each      = local.deploy_project_ids
  crypto_key_id = google_kms_crypto_key.key[each.key].id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.projects[each.key].number}@gcp-sa-artifactregistry.iam.gserviceaccount.com"
}

# Grant Cloud Run service agent permission to use the key
resource "google_kms_crypto_key_iam_member" "run_kms" {
  for_each      = local.deploy_project_ids
  crypto_key_id = google_kms_crypto_key.key[each.key].id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.projects[each.key].number}@serverless-robot-prod.iam.gserviceaccount.com"
}
