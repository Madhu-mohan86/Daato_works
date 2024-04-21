variable "kube_config_path" {
  type = string
}
variable "react_image" {
  type = string
}

variable "react_port" {
  type = number
}

variable "react_app_url" {
  type = string
}

variable "react_ingress_name" {
  type = string
  default = "react-ingress"
}

variable "react_host_name" {
  type = string
  default = "app.localhost"
}