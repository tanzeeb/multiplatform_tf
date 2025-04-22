variable "project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
}

variable "region" {
  description = "The GCP region for the GKE cluster."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone for the GKE cluster nodes."
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
  default     = "my-gke-cluster"
}

variable "machine_type" {
  description = "The machine type for the GKE nodes."
  type        = string
  default     = "e2-medium"
}

variable "initial_node_count" {
  description = "The initial number of nodes for the default node pool."
  type        = number
  default     = 1
}

variable "min_node_count" {
  description = "The minimum number of nodes for the node pool autoscaling."
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "The maximum number of nodes for the node pool autoscaling."
  type        = number
  default     = 3
}
