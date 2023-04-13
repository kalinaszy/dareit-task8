terraform {
  required_version = ">= 1.0.11"
  backend "gcs" {
    credentials = "infra-optics-379215-5ed82b71ac17.json"
    bucket = "terraform-bucket-task8"
    prefix = "dev"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.41.0"
    }
  }
}
