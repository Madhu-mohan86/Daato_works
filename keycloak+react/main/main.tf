module "cluster" {
  source      = "../modules/cluster"
  cluster_name = "homosapiens"
}

module "ingress_controller" {
  source = "../modules/ingress_controller"
  kube_config_path=module.cluster.kind_cluster
}

module "keycloak" {
  source = "../modules/keycloak"
  kube_config_path = module.cluster.kind_cluster
  keycloak_image = "quay.io/keycloak/keycloak:24.0.2"
  keycloak_port = 8080
}

module "react" {
  source = "../modules/react"
  kube_config_path = module.cluster.kind_cluster
  react_image = "madhu86/iamreact1"
  react_port = 3000
  react_app_url = "http://auth.localhost/"
 }