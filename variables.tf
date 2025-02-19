variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default = "msinghi-experimental4"
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
  default = "msinghi-test"
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

variable "ssh_public_key" {
  description = "SSH public key for instance access"
  type        = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICLRkL7TEmx+8boZrartiWxr6NQdo9rMuQ/XIkRNm5uP mayanksinghi@gmail.com"
}

variable "ssh_user" {
  description = "SSH user for instance access"
  type        = string
  default     = "admin"
}

variable "customer_name" {
  type = string
  description = "name of customer"
  default = "unknown"
}

variable "allowed_ip" {
  description = "IP address allowed for SSH access (CIDR notation)"
  type        = string
  default = "50.35.69.244"
}

variable "login_user" {
  type = string
  default = "msinghi"
}

variable "login_password" {
  type = string
  default = "mypwd"
}