locals {
  tls_secret_name        = var.tls_certificate_type == "let_s_encrypt" ? "letsencrypt-prod" : "custom-tls-secret"
  kube_config            = data.azurerm_kubernetes_cluster.current.kube_admin_config
  host                   = local.kube_config.0.host
  client_certificate     = base64decode(local.kube_config.0.client_certificate)
  client_key             = base64decode(local.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(local.kube_config.0.cluster_ca_certificate)
}

data "azurerm_kubernetes_cluster" "current" {
  name                = var.cluster_name
  resource_group_name = var.kubernetes_resource_group
}

