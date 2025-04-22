variable "cluster_endpoint" {
  description = "The endpoint IP address of the Kubernetes cluster master."
  type        = string
  sensitive   = true
}

variable "cluster_ca_certificate" {
  description = "Base64 encoded cluster certificate authority data."
  type        = string
  sensitive   = true
}

variable "app_name" {
  description = "The name for the Kubernetes deployment and service."
  type        = string
  default     = "nginx-hello-world"
}

variable "app_image" {
  description = "The container image for the application."
  type        = string
  default     = "nginx:latest"
}

variable "app_replicas" {
  description = "The number of replicas for the application deployment."
  type        = number
  default     = 2
}

variable "service_port" {
  description = "The port the service will expose."
  type        = number
  default     = 80
}

variable "container_port" {
  description = "The port the container listens on."
  type        = number
  default     = 80
}

variable "service_type" {
  description = "The type of Kubernetes service to create (e.g., LoadBalancer, ClusterIP)."
  type        = string
  default     = "LoadBalancer"
}
