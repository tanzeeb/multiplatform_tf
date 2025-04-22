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

provider "google" {
  project = var.project_id # Define project_id in terraform.tfvars or via -var flag
  region  = var.region     # Define region in terraform.tfvars or via -var flag
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


# Instantiate the GKE Cluster Module
module "gke_cluster" {
  source = "./modules/gke_cluster"

  project_id   = var.project_id
  region       = var.region
  zone         = var.zone # Pass the zone to the cluster module
  cluster_name = "my-split-cluster"
  # Add other overrides if needed
}

# Instantiate the Kubernetes Workload Module
module "k8s_nginx_app" {
  source = "./modules/k8s_workload"

  # Pass outputs from the cluster module as inputs here
  cluster_endpoint        = module.gke_cluster.cluster_endpoint
  cluster_ca_certificate  = module.gke_cluster.cluster_ca_certificate

  # Configure the application
  app_name     = "nginx-split-demo"
  app_image    = "nginx:stable"
  app_replicas = 2
  service_type = "LoadBalancer"

  # Ensure workload module runs after cluster module is complete
  # Although Terraform usually infers this from variable passing,
  # explicit dependency can be clearer.
  depends_on = [module.gke_cluster]
}

# Output the Load Balancer IP from the workload module
output "application_load_balancer_ip" {
  description = "External IP address of the deployed application's Load Balancer."
  value       = module.k8s_nginx_app.service_load_balancer_ip
}

output "cluster_name" {
    description = "Name of the GKE cluster created"
    value = module.gke_cluster.cluster_name
}
