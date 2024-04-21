
output "react_service" {
  value = kubernetes_service.react_service.metadata[0].name
}

output "react_service_port" {
  value = var.react_port
}