resource "kind_cluster" "daato" {
  name            = var.cluster_name
  wait_for_ready  = true
  kubeconfig_path = pathexpand("~/.kube/config")

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
      
      kubeadm_config_patches = [
        yamlencode({
          kind = "InitConfiguration"
          nodeRegistration = {
            kubeletExtraArgs = {
              "node-labels" = "ingress-ready=true"
            }
          }
        })
      ]
      extra_port_mappings {
        container_port = 80
        host_port      = 80
      } 
      extra_port_mappings{
        container_port=443
        host_port=443
      }
  }

      node {
      role = "worker"
    }
}
}