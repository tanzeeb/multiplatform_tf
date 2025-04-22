terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20" # Specify appropriate version constraints
    }
    # Removed explicit google provider requirement as data source was removed
  }
}
