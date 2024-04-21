resource "kubernetes_secret_v1" "name" {
  metadata {
    name = "wildcard-tls"
  }
  data = {
    "tls.crt"=file("${pathexpand("~")}/_wildcard.localhost.pem")
    "tls.key"=file("${pathexpand("~")}/_wildcard.localhost-key.pem")
  }
  type = "kubernetes.io/tls"
}