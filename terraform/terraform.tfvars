{
  "version": 4,
  "terraform_version": "1.5.7",
  "serial": 98,
  "lineage": "e92515f8-001a-eb19-771a-a0d3d19d2373",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "google_compute_firewall",
      "name": "allow_all_internal_ingress",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [],
                "protocol": "all"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.876-07:00",
            "deny": [],
            "description": "",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/my-project-60155-aa/global/firewalls/allow-all-internal-ingress",
            "log_config": [],
            "name": "allow-all-internal-ingress",
            "network": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/networks/default",
            "params": [],
            "priority": 900,
            "project": "my-project-60155-aa",
            "self_link": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/firewalls/allow-all-internal-ingress",
            "source_ranges": [
              "10.0.0.0/8"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [],
                "protocol": "all"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.275-07:00",
            "deny": [],
            "description": "",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/rxo-gmail/global/firewalls/allow-all-internal-ingress",
            "log_config": [],
            "name": "allow-all-internal-ingress",
            "network": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/networks/default",
            "params": [],
            "priority": 900,
            "project": "rxo-gmail",
            "self_link": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/firewalls/allow-all-internal-ingress",
            "source_ranges": [
              "10.0.0.0/8"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_compute_firewall",
      "name": "allow_redis_egress",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [
                  "6379"
                ],
                "protocol": "tcp"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:12.132-07:00",
            "deny": [],
            "description": "",
            "destination_ranges": [
              "10.29.55.216/29"
            ],
            "direction": "EGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/my-project-60155-aa/global/firewalls/allow-redis-egress",
            "log_config": [],
            "name": "allow-redis-egress",
            "network": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/networks/default",
            "params": [],
            "priority": 1000,
            "project": "my-project-60155-aa",
            "self_link": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/firewalls/allow-redis-egress",
            "source_ranges": [],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [
                  "6379"
                ],
                "protocol": "tcp"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.046-07:00",
            "deny": [],
            "description": "",
            "destination_ranges": [
              "10.29.55.216/29"
            ],
            "direction": "EGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/rxo-gmail/global/firewalls/allow-redis-egress",
            "log_config": [],
            "name": "allow-redis-egress",
            "network": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/networks/default",
            "params": [],
            "priority": 1000,
            "project": "rxo-gmail",
            "self_link": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/firewalls/allow-redis-egress",
            "source_ranges": [],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_compute_firewall",
      "name": "default_allow_custom",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [],
                "protocol": "all"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.296-07:00",
            "deny": [],
            "description": "Allows connection from any source to any instance on the network using custom protocols.",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/my-project-60155-aa/global/firewalls/default-allow-custom",
            "log_config": [],
            "name": "default-allow-custom",
            "network": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/networks/default",
            "params": [],
            "priority": 65534,
            "project": "my-project-60155-aa",
            "self_link": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/firewalls/default-allow-custom",
            "source_ranges": [
              "10.128.0.0/9"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [],
                "protocol": "all"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.564-07:00",
            "deny": [],
            "description": "Allows connection from any source to any instance on the network using custom protocols.",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/rxo-gmail/global/firewalls/default-allow-custom",
            "log_config": [],
            "name": "default-allow-custom",
            "network": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/networks/default",
            "params": [],
            "priority": 65534,
            "project": "rxo-gmail",
            "self_link": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/firewalls/default-allow-custom",
            "source_ranges": [
              "10.128.0.0/9"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_compute_firewall",
      "name": "default_allow_icmp",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [],
                "protocol": "icmp"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.864-07:00",
            "deny": [],
            "description": "Allows ICMP connections from any source to any instance on the network.",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/my-project-60155-aa/global/firewalls/default-allow-icmp",
            "log_config": [],
            "name": "default-allow-icmp",
            "network": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/networks/default",
            "params": [],
            "priority": 65534,
            "project": "my-project-60155-aa",
            "self_link": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/firewalls/default-allow-icmp",
            "source_ranges": [
              "0.0.0.0/0"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [],
                "protocol": "icmp"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:22.545-07:00",
            "deny": [],
            "description": "Allows ICMP connections from any source to any instance on the network.",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/rxo-gmail/global/firewalls/default-allow-icmp",
            "log_config": [],
            "name": "default-allow-icmp",
            "network": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/networks/default",
            "params": [],
            "priority": 65534,
            "project": "rxo-gmail",
            "self_link": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/firewalls/default-allow-icmp",
            "source_ranges": [
              "0.0.0.0/0"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_compute_firewall",
      "name": "default_allow_rdp",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [
                  "3389"
                ],
                "protocol": "tcp"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:22.315-07:00",
            "deny": [],
            "description": "Allows RDP connections from any source to any instance on the network using port 3389.",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/my-project-60155-aa/global/firewalls/default-allow-rdp",
            "log_config": [],
            "name": "default-allow-rdp",
            "network": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/networks/default",
            "params": [],
            "priority": 65534,
            "project": "my-project-60155-aa",
            "self_link": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/firewalls/default-allow-rdp",
            "source_ranges": [
              "0.0.0.0/0"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [
                  "3389"
                ],
                "protocol": "tcp"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.176-07:00",
            "deny": [],
            "description": "Allows RDP connections from any source to any instance on the network using port 3389.",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/rxo-gmail/global/firewalls/default-allow-rdp",
            "log_config": [],
            "name": "default-allow-rdp",
            "network": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/networks/default",
            "params": [],
            "priority": 65534,
            "project": "rxo-gmail",
            "self_link": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/firewalls/default-allow-rdp",
            "source_ranges": [
              "0.0.0.0/0"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_compute_firewall",
      "name": "default_allow_ssh",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [
                  "22"
                ],
                "protocol": "tcp"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.097-07:00",
            "deny": [],
            "description": "Allows TCP connections from any source to any instance on the network using port 22.",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/my-project-60155-aa/global/firewalls/default-allow-ssh",
            "log_config": [],
            "name": "default-allow-ssh",
            "network": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/networks/default",
            "params": [],
            "priority": 65534,
            "project": "my-project-60155-aa",
            "self_link": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/firewalls/default-allow-ssh",
            "source_ranges": [
              "0.0.0.0/0"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 1,
          "attributes": {
            "allow": [
              {
                "ports": [
                  "22"
                ],
                "protocol": "tcp"
              }
            ],
            "creation_timestamp": "2026-03-21T21:08:11.905-07:00",
            "deny": [],
            "description": "Allows TCP connections from any source to any instance on the network using port 22.",
            "destination_ranges": [],
            "direction": "INGRESS",
            "disabled": false,
            "enable_logging": null,
            "id": "projects/rxo-gmail/global/firewalls/default-allow-ssh",
            "log_config": [],
            "name": "default-allow-ssh",
            "network": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/networks/default",
            "params": [],
            "priority": 65534,
            "project": "rxo-gmail",
            "self_link": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/firewalls/default-allow-ssh",
            "source_ranges": [
              "0.0.0.0/0"
            ],
            "source_service_accounts": [],
            "source_tags": [],
            "target_service_accounts": [],
            "target_tags": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_compute_global_address",
      "name": "private_ip_alloc",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 0,
          "attributes": {
            "address": "10.59.0.0",
            "address_type": "INTERNAL",
            "creation_timestamp": "2026-03-21T23:22:58.971-07:00",
            "description": "",
            "effective_labels": {
              "goog-terraform-provisioned": "true"
            },
            "id": "projects/my-project-60155-aa/global/addresses/private-ip-alloc",
            "ip_version": "",
            "label_fingerprint": "vezUS-42LLM=",
            "labels": {},
            "name": "private-ip-alloc",
            "network": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/networks/default",
            "prefix_length": 16,
            "project": "my-project-60155-aa",
            "purpose": "VPC_PEERING",
            "self_link": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/addresses/private-ip-alloc",
            "terraform_labels": {
              "goog-terraform-provisioned": "true"
            },
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 0,
          "attributes": {
            "address": "10.122.0.0",
            "address_type": "INTERNAL",
            "creation_timestamp": "2026-03-21T23:22:59.022-07:00",
            "description": "",
            "effective_labels": {
              "goog-terraform-provisioned": "true"
            },
            "id": "projects/rxo-gmail/global/addresses/private-ip-alloc",
            "ip_version": "",
            "label_fingerprint": "vezUS-42LLM=",
            "labels": {},
            "name": "private-ip-alloc",
            "network": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/networks/default",
            "prefix_length": 16,
            "project": "rxo-gmail",
            "purpose": "VPC_PEERING",
            "self_link": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/addresses/private-ip-alloc",
            "terraform_labels": {
              "goog-terraform-provisioned": "true"
            },
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_compute_network",
      "name": "default",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 0,
          "attributes": {
            "auto_create_subnetworks": true,
            "bgp_always_compare_med": false,
            "bgp_best_path_selection_mode": "LEGACY",
            "bgp_inter_region_cost": "",
            "delete_bgp_always_compare_med": false,
            "delete_default_routes_on_create": false,
            "description": "",
            "enable_ula_internal_ipv6": false,
            "gateway_ipv4": "",
            "id": "projects/my-project-60155-aa/global/networks/default",
            "internal_ipv6_range": "",
            "mtu": 0,
            "name": "default",
            "network_firewall_policy_enforcement_order": "AFTER_CLASSIC_FIREWALL",
            "network_id": "8534358895082264046",
            "network_profile": "",
            "numeric_id": "8534358895082264046",
            "params": [],
            "project": "my-project-60155-aa",
            "routing_mode": "REGIONAL",
            "self_link": "https://www.googleapis.com/compute/v1/projects/my-project-60155-aa/global/networks/default",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 0,
          "attributes": {
            "auto_create_subnetworks": true,
            "bgp_always_compare_med": false,
            "bgp_best_path_selection_mode": "LEGACY",
            "bgp_inter_region_cost": "",
            "delete_bgp_always_compare_med": false,
            "delete_default_routes_on_create": false,
            "description": "",
            "enable_ula_internal_ipv6": false,
            "gateway_ipv4": "",
            "id": "projects/rxo-gmail/global/networks/default",
            "internal_ipv6_range": "",
            "mtu": 0,
            "name": "default",
            "network_firewall_policy_enforcement_order": "AFTER_CLASSIC_FIREWALL",
            "network_id": "548472910228149742",
            "network_profile": "",
            "numeric_id": "548472910228149742",
            "params": [],
            "project": "rxo-gmail",
            "routing_mode": "REGIONAL",
            "self_link": "https://www.googleapis.com/compute/v1/projects/rxo-gmail/global/networks/default",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_project_service",
      "name": "enable_apis",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa_aiplatform.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/aiplatform.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "aiplatform.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_cloudbuild.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/cloudbuild.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "cloudbuild.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_cloudkms.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/cloudkms.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "cloudkms.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_cloudresourcemanager.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/cloudresourcemanager.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "cloudresourcemanager.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_cloudtrace.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/cloudtrace.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "cloudtrace.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_compute.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/compute.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "compute.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_iam.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/iam.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "iam.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_logging.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/logging.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "logging.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_redis.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/redis.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "redis.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_run.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/run.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "run.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_servicenetworking.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/servicenetworking.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "servicenetworking.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_serviceusage.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/serviceusage.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "serviceusage.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_telemetry.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/telemetry.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "telemetry.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "my-project-60155-aa_vpcaccess.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "my-project-60155-aa/vpcaccess.googleapis.com",
            "project": "my-project-60155-aa",
            "service": "vpcaccess.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_aiplatform.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/aiplatform.googleapis.com",
            "project": "rxo-gmail",
            "service": "aiplatform.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_cloudbuild.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/cloudbuild.googleapis.com",
            "project": "rxo-gmail",
            "service": "cloudbuild.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_cloudkms.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/cloudkms.googleapis.com",
            "project": "rxo-gmail",
            "service": "cloudkms.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_cloudresourcemanager.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/cloudresourcemanager.googleapis.com",
            "project": "rxo-gmail",
            "service": "cloudresourcemanager.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_cloudtrace.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/cloudtrace.googleapis.com",
            "project": "rxo-gmail",
            "service": "cloudtrace.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_compute.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/compute.googleapis.com",
            "project": "rxo-gmail",
            "service": "compute.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_iam.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/iam.googleapis.com",
            "project": "rxo-gmail",
            "service": "iam.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_logging.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/logging.googleapis.com",
            "project": "rxo-gmail",
            "service": "logging.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_redis.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/redis.googleapis.com",
            "project": "rxo-gmail",
            "service": "redis.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_run.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/run.googleapis.com",
            "project": "rxo-gmail",
            "service": "run.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_servicenetworking.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/servicenetworking.googleapis.com",
            "project": "rxo-gmail",
            "service": "servicenetworking.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_serviceusage.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/serviceusage.googleapis.com",
            "project": "rxo-gmail",
            "service": "serviceusage.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_telemetry.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/telemetry.googleapis.com",
            "project": "rxo-gmail",
            "service": "telemetry.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        },
        {
          "index_key": "rxo-gmail_vpcaccess.googleapis.com",
          "schema_version": 0,
          "attributes": {
            "disable_dependent_services": null,
            "disable_on_destroy": false,
            "id": "rxo-gmail/vpcaccess.googleapis.com",
            "project": "rxo-gmail",
            "service": "vpcaccess.googleapis.com",
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInJlYWQiOjYwMDAwMDAwMDAwMCwidXBkYXRlIjoxMjAwMDAwMDAwMDAwfX0="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_redis_instance",
      "name": "firstone",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 0,
          "attributes": {
            "alternative_location_id": "",
            "auth_enabled": false,
            "auth_string": "",
            "authorized_network": "projects/my-project-60155-aa/global/networks/default",
            "connect_mode": "PRIVATE_SERVICE_ACCESS",
            "create_time": "2026-03-22T06:24:22.638107367Z",
            "current_location_id": "us-central1-c",
            "customer_managed_key": "",
            "deletion_protection": null,
            "display_name": "",
            "effective_labels": {
              "goog-terraform-provisioned": "true",
              "managed-by-cnrm": "true"
            },
            "effective_reserved_ip_range": "10.59.0.0/29",
            "host": "10.59.0.3",
            "id": "projects/my-project-60155-aa/locations/us-central1/instances/firstone",
            "labels": {
              "managed-by-cnrm": "true"
            },
            "location_id": "us-central1-c",
            "maintenance_policy": [],
            "maintenance_schedule": [],
            "maintenance_version": "20251007_00_00",
            "memory_size_gb": 1,
            "name": "firstone",
            "nodes": [
              {
                "id": "node-0",
                "zone": "us-central1-c"
              }
            ],
            "persistence_config": [
              {
                "persistence_mode": "DISABLED",
                "rdb_next_snapshot_time": "",
                "rdb_snapshot_period": "",
                "rdb_snapshot_start_time": ""
              }
            ],
            "persistence_iam_identity": "serviceAccount:service-197836853060@cloud-redis.iam.gserviceaccount.com",
            "port": 6379,
            "project": "my-project-60155-aa",
            "read_endpoint": "",
            "read_endpoint_port": 0,
            "read_replicas_mode": "READ_REPLICAS_DISABLED",
            "redis_configs": {},
            "redis_version": "REDIS_7_0",
            "region": "us-central1",
            "replica_count": 0,
            "reserved_ip_range": null,
            "secondary_ip_range": "",
            "server_ca_certs": [],
            "terraform_labels": {
              "goog-terraform-provisioned": "true",
              "managed-by-cnrm": "true"
            },
            "tier": "BASIC",
            "timeouts": null,
            "transit_encryption_mode": "DISABLED"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_compute_global_address.private_ip_alloc",
            "google_compute_network.default",
            "google_project_service.enable_apis",
            "google_service_networking_connection.default"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 0,
          "attributes": {
            "alternative_location_id": "",
            "auth_enabled": false,
            "auth_string": "",
            "authorized_network": "projects/rxo-gmail/global/networks/default",
            "connect_mode": "PRIVATE_SERVICE_ACCESS",
            "create_time": "2026-03-22T06:24:22.664949424Z",
            "current_location_id": "us-central1-c",
            "customer_managed_key": "",
            "deletion_protection": null,
            "display_name": "",
            "effective_labels": {
              "goog-terraform-provisioned": "true",
              "managed-by-cnrm": "true"
            },
            "effective_reserved_ip_range": "10.122.0.0/29",
            "host": "10.122.0.3",
            "id": "projects/rxo-gmail/locations/us-central1/instances/firstone",
            "labels": {
              "managed-by-cnrm": "true"
            },
            "location_id": "us-central1-c",
            "maintenance_policy": [],
            "maintenance_schedule": [],
            "maintenance_version": "20251007_00_00",
            "memory_size_gb": 1,
            "name": "firstone",
            "nodes": [
              {
                "id": "node-0",
                "zone": "us-central1-c"
              }
            ],
            "persistence_config": [
              {
                "persistence_mode": "DISABLED",
                "rdb_next_snapshot_time": "",
                "rdb_snapshot_period": "",
                "rdb_snapshot_start_time": ""
              }
            ],
            "persistence_iam_identity": "serviceAccount:service-222705472325@cloud-redis.iam.gserviceaccount.com",
            "port": 6379,
            "project": "rxo-gmail",
            "read_endpoint": "",
            "read_endpoint_port": 0,
            "read_replicas_mode": "READ_REPLICAS_DISABLED",
            "redis_configs": {},
            "redis_version": "REDIS_7_0",
            "region": "us-central1",
            "replica_count": 0,
            "reserved_ip_range": null,
            "secondary_ip_range": "",
            "server_ca_certs": [],
            "terraform_labels": {
              "goog-terraform-provisioned": "true",
              "managed-by-cnrm": "true"
            },
            "tier": "BASIC",
            "timeouts": null,
            "transit_encryption_mode": "DISABLED"
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_compute_global_address.private_ip_alloc",
            "google_compute_network.default",
            "google_project_service.enable_apis",
            "google_service_networking_connection.default"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_service_networking_connection",
      "name": "default",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 0,
          "attributes": {
            "deletion_policy": null,
            "id": "projects%2Fmy-project-60155-aa%2Fglobal%2Fnetworks%2Fdefault:servicenetworking.googleapis.com",
            "network": "projects/my-project-60155-aa/global/networks/default",
            "peering": "servicenetworking-googleapis-com",
            "reserved_peering_ranges": [
              "private-ip-alloc"
            ],
            "service": "servicenetworking.googleapis.com",
            "timeouts": null,
            "update_on_creation_fail": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_compute_global_address.private_ip_alloc",
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 0,
          "attributes": {
            "deletion_policy": null,
            "id": "projects%2Frxo-gmail%2Fglobal%2Fnetworks%2Fdefault:servicenetworking.googleapis.com",
            "network": "projects/rxo-gmail/global/networks/default",
            "peering": "servicenetworking-googleapis-com",
            "reserved_peering_ranges": [
              "private-ip-alloc"
            ],
            "service": "servicenetworking.googleapis.com",
            "timeouts": null,
            "update_on_creation_fail": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6NjAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_compute_global_address.private_ip_alloc",
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_vpc_access_connector",
      "name": "connector",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "index_key": "my-project-60155-aa",
          "schema_version": 0,
          "attributes": {
            "connected_projects": [],
            "id": "projects/my-project-60155-aa/locations/us-central1/connectors/vpc-conn",
            "ip_cidr_range": "10.8.0.0/28",
            "machine_type": "e2-micro",
            "max_instances": 10,
            "max_throughput": 1000,
            "min_instances": 2,
            "min_throughput": 200,
            "name": "vpc-conn",
            "network": "default",
            "project": "my-project-60155-aa",
            "region": "us-central1",
            "self_link": "projects/my-project-60155-aa/locations/us-central1/connectors/vpc-conn",
            "state": "READY",
            "subnet": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        },
        {
          "index_key": "rxo-gmail",
          "schema_version": 0,
          "attributes": {
            "connected_projects": [],
            "id": "projects/rxo-gmail/locations/us-central1/connectors/vpc-conn",
            "ip_cidr_range": "10.8.0.0/28",
            "machine_type": "e2-micro",
            "max_instances": 10,
            "max_throughput": 1000,
            "min_instances": 2,
            "min_throughput": 200,
            "name": "vpc-conn",
            "network": "default",
            "project": "rxo-gmail",
            "region": "us-central1",
            "self_link": "projects/rxo-gmail/locations/us-central1/connectors/vpc-conn",
            "state": "READY",
            "subnet": [],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH19",
          "dependencies": [
            "google_compute_network.default",
            "google_project_service.enable_apis"
          ]
        }
      ]
    }
  ],
  "check_results": null
}
