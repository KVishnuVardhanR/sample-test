locals {
  # Combine the two project variables into a single list
  projects = [var.dev_project_id, var.prod_project_id]

  # Create a flattened map of all project and API combinations
  project_apis = flatten([
    for project in local.projects : [
      for api in var.gcp_service_list : {
        project = project
        service = api
      }
    ]
  ])
}

# Enable the APIs for both the prod and dev projects
resource "google_project_service" "enable_apis" {
  for_each = {
    for pa in local.project_apis : "${pa.project}_${pa.service}" => pa
  }

  project = each.value.project
  service = each.value.service

  disable_on_destroy = false
}

# --- Default Network Firewall Rules ---

resource "google_compute_network" "default" {
  for_each                = toset(local.projects)
  name                    = "default"
  auto_create_subnetworks = true
  project                 = each.value

  depends_on = [google_project_service.enable_apis]
}

resource "google_compute_firewall" "allow_all_internal_ingress" {
  for_each = toset(local.projects)
  allow {
    protocol = "all"
  }
  direction     = "INGRESS"
  name          = "allow-all-internal-ingress"
  network       = google_compute_network.default[each.value].id
  priority      = 900
  project       = each.value
  source_ranges = ["10.0.0.0/8"]

  depends_on = [google_project_service.enable_apis]
}

resource "google_compute_firewall" "allow_redis_egress" {
  for_each = toset(local.projects)
  allow {
    ports    = ["6379"]
    protocol = "tcp"
  }
  destination_ranges = ["10.29.55.216/29"]
  direction          = "EGRESS"
  name               = "allow-redis-egress"
  network            = google_compute_network.default[each.value].id
  priority           = 1000
  project            = each.value

  depends_on = [google_project_service.enable_apis]
}

resource "google_compute_firewall" "default_allow_custom" {
  for_each = toset(local.projects)
  allow {
    protocol = "all"
  }
  description   = "Allows connection from any source to any instance on the network using custom protocols."
  direction     = "INGRESS"
  name          = "default-allow-custom"
  network       = google_compute_network.default[each.value].id
  priority      = 65534
  project       = each.value
  source_ranges = ["10.128.0.0/9"]

  depends_on = [google_project_service.enable_apis]
}

resource "google_compute_firewall" "default_allow_icmp" {
  for_each = toset(local.projects)
  allow {
    protocol = "icmp"
  }
  description   = "Allows ICMP connections from any source to any instance on the network."
  direction     = "INGRESS"
  name          = "default-allow-icmp"
  network       = google_compute_network.default[each.value].id
  priority      = 65534
  project       = each.value
  source_ranges = ["0.0.0.0/0"]

  depends_on = [google_project_service.enable_apis]
}

resource "google_compute_global_address" "private_ip_alloc" {
  for_each      = toset(local.projects)
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.default[each.value].id
  project       = each.value

  depends_on = [google_project_service.enable_apis]
}

resource "google_service_networking_connection" "default" {
  for_each                = toset(local.projects)
  network                 = google_compute_network.default[each.value].id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc[each.value].name]

  depends_on = [google_project_service.enable_apis]
}

resource "google_redis_instance" "firstone" {
  for_each           = toset(local.projects)
  authorized_network = google_compute_network.default[each.value].id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"
  labels = {
    managed-by-cnrm = "true"
  }
  location_id    = "us-central1-c"
  memory_size_gb = 1
  name           = "firstone"
  persistence_config {
    persistence_mode = "DISABLED"
  }
  project                 = each.value
  read_replicas_mode      = "READ_REPLICAS_DISABLED"
  redis_version           = "REDIS_7_0"
  region                  = "us-central1"
  tier                    = "BASIC"
  transit_encryption_mode = "DISABLED"

  depends_on = [
    google_project_service.enable_apis,
    google_service_networking_connection.default
  ]
}

resource "google_compute_firewall" "default_allow_rdp" {
  for_each = toset(local.projects)
  allow {
    ports    = ["3389"]
    protocol = "tcp"
  }
  description   = "Allows RDP connections from any source to any instance on the network using port 3389."
  direction     = "INGRESS"
  name          = "default-allow-rdp"
  network       = google_compute_network.default[each.value].id
  priority      = 65534
  project       = each.value
  source_ranges = ["0.0.0.0/0"]

  depends_on = [google_project_service.enable_apis]
}

resource "google_compute_firewall" "default_allow_ssh" {
  for_each = toset(local.projects)
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  description   = "Allows TCP connections from any source to any instance on the network using port 22."
  direction     = "INGRESS"
  name          = "default-allow-ssh"
  network       = google_compute_network.default[each.value].id
  priority      = 65534
  project       = each.value
  source_ranges = ["0.0.0.0/0"]

  depends_on = [google_project_service.enable_apis]
}

resource "google_storage_bucket" "rxo_rate_card" {
  for_each      = toset(local.projects)
  name          = "rxo-rate-card-${each.value}"
  project       = each.value
  location      = "US"
  uniform_bucket_level_access = true

  depends_on = [google_project_service.enable_apis]
}

resource "google_vpc_access_connector" "connector" {
  for_each      = toset(local.projects)
  name          = "vpc-conn"
  project       = each.value
  region        = "us-central1"
  network       = google_compute_network.default[each.value].name
  ip_cidr_range = "10.8.0.0/28"
  min_instances = 2
  max_instances = 10
  machine_type  = "e2-micro"

  depends_on = [google_project_service.enable_apis]
}