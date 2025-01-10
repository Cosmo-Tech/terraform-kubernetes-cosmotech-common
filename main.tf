locals {
  tls_secret_name        = var.tls_certificate_type == "let_s_encrypt" ? "letsencrypt-prod" : "custom-tls-secret"
  kube_config            = var.kubernetes_cluster_admin_activate ? data.azurerm_kubernetes_cluster.current.kube_admin_config : data.azurerm_kubernetes_cluster.current.kube_config
  host                   = local.kube_config.0.host
  client_certificate     = base64decode(local.kube_config.0.client_certificate)
  client_key             = base64decode(local.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(local.kube_config.0.cluster_ca_certificate)
}

data "azurerm_kubernetes_cluster" "current" {
  name                = var.cluster_name
  resource_group_name = var.kubernetes_resource_group
}


data "terraform_remote_state" "core_infra" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.tf_resource_group_name
    storage_account_name = var.tf_storage_account_name
    container_name       = var.tf_container_name
    key                  = var.tf_blob_name_core_infra
    access_key           = var.tf_access_key
  }
}

data "terraform_remote_state" "tenant_infra" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.tf_resource_group_name
    storage_account_name = var.tf_storage_account_name
    container_name       = var.tf_container_name
    key                  = var.tf_blob_name_tenant_infra
    access_key           = var.tf_access_key
  }
}

data "template_file" "example" {
  template = file("${path.module}/summary.tpl.md")
  vars = {
    tenant_id            = data.terraform_remote_state.core_infra.outputs.out_tenant_id
    subscription_id      = data.terraform_remote_state.core_infra.outputs.out_subscription_id
    subscription_name    = "Azure NMN Cosmotech"
    azure_resource_group = data.terraform_remote_state.core_infra.outputs.out_kubernetes_resource_group

    out_acr_login_server_url     = data.terraform_remote_state.tenant_infra.outputs.out_acr_login_server_url
    out_adx_cluster_name         = data.terraform_remote_state.tenant_infra.outputs.out_adx_cluster_name
    out_adx_cluster_principal_id = data.terraform_remote_state.tenant_infra.outputs.out_adx_cluster_principal_id
    out_adx_cluster_uri          = data.terraform_remote_state.tenant_infra.outputs.out_adx_cluster_uri
    out_api_cosmo_url            = data.terraform_remote_state.tenant_infra.outputs.out_api_cosmo_url
    out_api_cosmo_scope          = data.terraform_remote_state.tenant_infra.outputs.out_api_cosmo_scope

    kubernetes_cluster_version        = "1.31.2"
    cluster_region                    = "france central"
    network_name                      = data.terraform_remote_state.core_infra.outputs.out_network_name
    network_publicip_name             = data.terraform_remote_state.core_infra.outputs.out_publicip_name
    network_publicip_address          = data.terraform_remote_state.core_infra.outputs.out_publicip_address
    api_dns_name                      = data.terraform_remote_state.core_infra.outputs.out_api_dns_name
    kubernetes_cluster_name           = data.terraform_remote_state.core_infra.outputs.out_cluster_name
    kubernetes_system_node_pool_vm    = "Standard_A2_v2"
    kubernetes_nodepool_vm_services   = "Standard_B4ms"
    kubernetes_nodepool_vm_monitoring = "Standard_D2ads_v5"
    kubernetes_nodepool_vm_highmemory = "Standard_E16ads_v5"
    kubernetes_nodepool_vm_highcpy    = "Standard_F72s_v2"
    kubernetes_nodepool_vm_database   = "Standard_D2ads_v5"
    kubernetes_nodepool_vm_basic      = "Standard_F4s_v2"

    argocd_deploy  = true
    argocd_version = "1321"
    vault_deploy   = true
    vault_version  = "1.532"
    sops_deploy    = true
    sops_version   = "654"

    grafana_deploy = true

  }
}
