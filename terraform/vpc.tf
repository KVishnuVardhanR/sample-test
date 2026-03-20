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

resource "google_compute_network" "vpc_network" {
  for_each                = local.deploy_project_ids
  name                    = local.vpc_name
  project                 = each.value
  auto_create_subnetworks = true
}

resource "google_vpc_access_connector" "connector" {
  for_each      = local.deploy_project_ids
  name          = "vpc-conn"
  project       = each.value
  region        = var.region
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.vpc_network[each.key].name

  depends_on = [google_project_service.deploy_project_services]
}
