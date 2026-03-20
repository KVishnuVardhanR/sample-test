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

resource "google_redis_instance" "cache" {
  for_each           = local.deploy_project_ids
  name               = "${var.project_name}-cache"
  tier               = "BASIC"
  memory_size_gb     = 1
  location_id        = "${var.region}-a"
  authorized_network = google_compute_network.vpc_network[each.key].id
  project            = each.value
  redis_version      = "REDIS_6_X"

  depends_on = [google_project_service.deploy_project_services]
}
