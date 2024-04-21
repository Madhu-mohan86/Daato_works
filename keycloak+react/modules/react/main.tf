resource "kubernetes_deployment" "react_deployment" {
metadata {
  name = "react"
  labels = {
    app="reactdplymnt"
  }
}
spec {
  selector {
    match_labels = {
      app="react"
    }
  }
  template {
    metadata {
      labels = {
        app="react"
      }
    }
    
    spec {
      container {
        name = "react"
        image = var.react_image
        env {
          name = "REACT_APP_URL"
          value = var.react_app_url
        }
        port {
          container_port = var.react_port
        }
      }
    }
  }
}
}

resource "kubernetes_service" "react_service" {
  metadata {
    name = kubernetes_deployment.react_deployment.metadata[0].name
    labels = {
      app="react_service"
    }
  }
  spec {
    selector = {
      app="react"
    }
    type = "NodePort"
    port {
     port = var.react_port
     target_port = var.react_port
    }
  }
}


resource "kubernetes_ingress_v1" "react_ingress" {
   metadata {
    name = var.react_ingress_name
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.react_host_name
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.react_service.metadata[0].name
              port {
                number = kubernetes_service.react_service.spec[0].port[0].port
              }
            }
          }
        }
      }
    }
}
}