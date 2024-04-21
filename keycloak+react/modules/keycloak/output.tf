output "keycloak_service" {
  value = kubernetes_service.keycloak_service.metadata[0].name
}

output "keycloak_service_port" {
  value = var.keycloak_port
}