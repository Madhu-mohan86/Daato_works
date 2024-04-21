variable "kube_config_path" {
  type = string
}

variable "keycloak_image" {
  type = string
}

variable "keycloak_port" {
  type = number
}

variable "keycloak_ingress_name" {
  type = string
  default = "keycloak-ingress"
}

variable "keycloak_host_name" {
  type = string
  default = "auth.localhost"
}
