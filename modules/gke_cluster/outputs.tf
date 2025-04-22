output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "The endpoint IP address of the GKE cluster master."
  value       = google_container_cluster.primary.endpoint
  sensitive   = true
}

output "cluster_location" {
  description = "The location (zone) of the GKE cluster."
  value       = google_container_cluster.primary.location
}

output "cluster_ca_certificate" {
  description = "The base64 encoded cluster certificate authority data."
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "node_pool_name" {
  description = "The name of the primary node pool."
  value       = google_container_node_pool.primary_nodes.name
}
