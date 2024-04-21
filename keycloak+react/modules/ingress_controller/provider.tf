terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.13.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config_path
  }
}