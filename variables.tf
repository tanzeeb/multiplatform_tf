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
  default = "my-fancy-saas-vm"
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

# New variable to control whether to create default VPC
variable "create_vpc" {
  description = "Whether to create the default VPC if it doesn't exist"
  type        = bool
  default     = false
}

# Variable for VPC name
variable "vpc_name" {
  description = "Name of the VPC network to use"
  type        = string
  default     = "default"
}