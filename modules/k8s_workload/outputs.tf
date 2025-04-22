output "deployment_name" {
  description = "Name of the Kubernetes deployment created."
  value       = kubernetes_deployment.app.metadata[0].name
}

output "service_name" {
  description = "Name of the Kubernetes service created."
  value       = kubernetes_service.app_service.metadata[0].name
}

output "service_cluster_ip" {
  description = "Cluster IP address of the service (if applicable)."
  value       = kubernetes_service.app_service.spec[0].cluster_ip
}

output "service_load_balancer_ip" {
  description = "External IP address of the LoadBalancer service. May take a few minutes to become available."
  # Accessing status requires the resource to be fully provisioned.
  # This attempts to get the IP, but might be empty initially.
  value = try(kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].ip, "Pending")
}
