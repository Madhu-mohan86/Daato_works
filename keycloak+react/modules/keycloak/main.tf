resource "kubernetes_deployment" "keycloak_deployment" {
   metadata {
     name = "keycloak"
     labels = {
         app="keycloakdplymnt"
     }
   }
   spec {

    selector {
      match_labels = {
        app="keycloak"
      }
    }
     template {
       metadata {
         labels = {
           app="keycloak"
         }
       }
       
       spec {
        container {
          name = "keycloak"
          image = var.keycloak_image
          args = ["start-dev"]
          env {
            name = "KEYCLOAK_ADMIN"
            value = "admin"
          }
          env {
            name = "KEYCLOAK_ADMIN_PASSWORD"
            value = "admin"
          }
          env {
            name = "KC_PROXY"
            value = "edge"
          }
          port {
            name = "http"
            container_port = var.keycloak_port
          }
          readiness_probe {
            http_get {
              path = "/realms/master"
              port = 8080
            }
          }
        }
       }
     }
   }
}

resource "kubernetes_service" "keycloak_service" {
  metadata {
    name = kubernetes_deployment.keycloak_deployment.metadata[0].name
    labels = {
      app="keycloak_service"
    }
  }
  spec {
    selector = {
      app="keycloak"
    }
    port {
      port = var.keycloak_port
      target_port = var.keycloak_port
    }
  }
}

resource "kubernetes_ingress_v1" "keycloak_ingress" {
  metadata {
    name = var.keycloak_ingress_name
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.keycloak_host_name
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.keycloak_service.metadata[0].name
              port {
                number = kubernetes_service.keycloak_service.spec[0].port
              }
            }
          }
        }
      }
    }
  }
}
