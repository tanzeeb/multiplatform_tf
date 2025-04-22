# Required for Kubernetes provider authentication using gcloud credentials
data "google_client_config" "default" {}

# Kubernetes Provider Configuration
# Configures the Kubernetes provider to interact with the target GKE cluster.
provider "kubernetes" {
  host                   = "https://${var.cluster_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

# Kubernetes Deployment Resource
resource "kubernetes_deployment" "app" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.app_replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          image = var.app_image
          name  = var.app_name

          ports {
            container_port = var.container_port
          }
        }
      }
    }
  }
}

# Kubernetes Service Resource
# Exposes the deployment based on the specified service type.
resource "kubernetes_service" "app_service" {
  metadata {
    name = "${var.app_name}-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment.app.metadata[0].labels.app
    }
    port {
      port        = var.service_port
      target_port = var.container_port # Target the container port
    }
    type = var.service_type
  }
  # Depends on the deployment being created
  depends_on = [
    kubernetes_deployment.app
  ]
}
