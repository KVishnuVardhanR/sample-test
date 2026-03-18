terraform {
  backend "gcs" {
    bucket = "rxo-gmail-terraform-state"
    prefix = "vague_descriptions_classify/prod"
  }
}
