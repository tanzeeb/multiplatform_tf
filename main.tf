terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

# Configure the Google provider in the root module
provider "google" {
  project = var.project_id
  region  = var.region
}

# Configure the Kubernetes provider in the root module
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = module.gke_cluster.cluster_endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.cluster_ca_certificate)
}

# Instantiate the GKE Cluster Module
module "gke_cluster" {
  source = "./modules/gke_cluster"

  # Pass standard variables
  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  # ... other cluster variables ...

  # Explicitly pass the provider configuration
  providers = {
    google = google # Pass the root module's google provider config
  }
}

# Instantiate the Kubernetes Workload Module
module "k8s_nginx_app" {
  source = "./modules/k8s_workload"

  # Pass standard variables
  app_name     = "nginx-passed-provider"
  app_replicas = 1

  # Explicitly pass the provider configurations
  providers = {
    kubernetes = kubernetes # Pass the root module's k8s provider config
    # google = google      # Pass google if the module needed it (e.g., for data sources)
  }

  depends_on = [module.gke_cluster]
}

# Define root variables (can be in variables.tf or passed via tfvars/command line)
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-c" # Example zone
}

# Output the Load Balancer IP from the workload module
output "application_load_balancer_ip" {
  description = "External IP address of the deployed application's Load Balancer."
  value       = module.k8s_nginx_app.service_load_balancer_ip
}

output "cluster_name" {
  description = "Name of the GKE cluster created"
  value       = module.gke_cluster.cluster_name
}
