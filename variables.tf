variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "Name for the GCE instance"
  type        = string
  default = "msinghi-test-new"
}

variable "machine_type" {
  description = "Machine type for the GCE instance"
  type        = string
  default = "e2-medium"
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default = 10
}

variable "customer_name" {
  type = string
  description = "name of customer"
  default = "unknown"
}

variable "ssh_source_ranges" {
  description = "CIDR blocks that can access the VM via SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# New variable to control whether to create default VPC
variable "create_default_vpc" {
  description = "Whether to create the default VPC if it doesn't exist"
  type        = bool
  default     = false
}