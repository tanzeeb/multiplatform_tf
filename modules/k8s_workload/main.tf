# Kubernetes Deployment Resource
resource "kubernetes_deployment" "app" {
  # No provider alias needed, uses the default passed from the caller.
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
resource "kubernetes_service" "app_service" {
  # No provider alias needed, uses the default passed from the caller.
  metadata {
    name = "${var.app_name}-service"
  }
  spec {
    selector = {
      # Reference the deployment's label selector correctly
      app = kubernetes_deployment.app.spec[0].selector[0].match_labels.app
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
