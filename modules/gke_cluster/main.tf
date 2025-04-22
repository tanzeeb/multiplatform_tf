# GKE Cluster Resource
resource "google_container_cluster" "primary" {
  project                  = var.project_id
  name                     = var.cluster_name
  location                 = var.zone # Deploying a zonal cluster for simplicity
  remove_default_node_pool = true     # We'll define our own node pool
  initial_node_count       = 1        # Required even if removing default pool

  # Networking configuration (using default VPC for simplicity)
  # Consider parameterizing network/subnetwork for more flexibility
  network    = "default"
  subnetwork = "default"

  # Enable necessary addons
  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  # Define the primary node pool configuration defaults
  # Specific node pool is created below
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    machine_type = var.machine_type
    tags         = ["gke-node", var.cluster_name]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  # Lifecycle rule to prevent accidental deletion
  lifecycle {
    prevent_destroy = false # Set to true in production if needed
  }

  # Master authentication block needed for outputs
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# GKE Node Pool Resource
resource "google_container_node_pool" "primary_nodes" {
  project    = var.project_id
  name       = "${var.cluster_name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.initial_node_count

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    machine_type = var.machine_type
    tags         = ["gke-node", var.cluster_name]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  # Ensure cluster is created before node pool
  depends_on = [google_container_cluster.primary]
}
