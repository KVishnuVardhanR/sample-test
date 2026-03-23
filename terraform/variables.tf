variable "prod_project_id" {
  type        = string
  description = "The Google Cloud Project ID for the prod environment."
}

variable "dev_project_id" {
  type        = string
  description = "The Google Cloud Project ID for the dev environment."
}

variable "gcp_service_list" {
  type        = list(string)
  description = "List of GCP APIs to enable."
  default     = []
}