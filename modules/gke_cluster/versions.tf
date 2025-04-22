terraform {
  required_providers {
    # This module requires the Google provider to manage GCP resources like GKE clusters and node pools.
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # Specify appropriate version constraints
    }
  }
}
