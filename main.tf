locals {
  tls_secret_name = var.tls_certificate_type == "let_s_encrypt" ? "letsencrypt-prod" : "custom-tls-secret"
}

data "terraform_remote_state" "core_ip" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.tf_resource_group_name
    storage_account_name = var.tf_storage_account_name
    container_name       = var.tf_container_name
    key                  = var.tf_blob_name_core_ip
    access_key           = var.tf_access_key
  }
}

data "terraform_remote_state" "core_dns" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.tf_resource_group_name_dns
    storage_account_name = var.tf_storage_account_name_dns
    container_name       = var.tf_container_name_dns
    key                  = var.tf_blob_name_core_dns
    access_key           = var.tf_access_key_dns
  }
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

data "template_file" "example" {
  template = file("${path.module}/summary.tpl.md")
  vars = {
    network_publicip_name    = data.terraform_remote_state.core_ip.outputs.out_network_publicip_name
    network_publicip_address = data.terraform_remote_state.core_ip.outputs.out_network_publicip_address
    api_dns_name             = data.terraform_remote_state.core_dns.outputs.out_api_dns_name

    network_app_name     = data.terraform_remote_state.core_infra.outputs.out_network_app_name
    network_sp_client_id = data.terraform_remote_state.core_infra.outputs.out_network_sp_client_id
    network_sp_object_id = data.terraform_remote_state.core_infra.outputs.out_network_sp_object_id
    tenant_id            = data.terraform_remote_state.core_infra.outputs.out_tenant_id
    subscription_id      = data.terraform_remote_state.core_infra.outputs.out_subscription_id
    azure_resource_group = data.terraform_remote_state.core_infra.outputs.out_kubernetes_resource_group
    cluster_region       = data.terraform_remote_state.core_infra.outputs.out_location

    network_name                          = data.terraform_remote_state.core_infra.outputs.out_network_name
    kubernetes_cluster_version            = data.terraform_remote_state.core_infra.outputs.out_kubernetes_version
    kubernetes_cluster_name               = data.terraform_remote_state.core_infra.outputs.out_cluster_name
    kubernetes_nodepool_vm_system         = data.terraform_remote_state.core_infra.outputs.out_kubernetes_nodepool_system_type
    kubernetes_nodepool_vm_services       = data.terraform_remote_state.core_infra.outputs.out_kubernetes_services_type
    kubernetes_nodepool_vm_monitoring     = data.terraform_remote_state.core_infra.outputs.out_kubernetes_monitoring_type
    kubernetes_nodepool_vm_highmemory     = data.terraform_remote_state.core_infra.outputs.out_kubernetes_highmemory_compute_type
    kubernetes_nodepool_vm_highcpu        = data.terraform_remote_state.core_infra.outputs.out_kubernetes_highcpu_compute_type
    kubernetes_nodepool_vm_database       = data.terraform_remote_state.core_infra.outputs.out_kubernetes_db_type
    kubernetes_nodepool_vm_basic          = data.terraform_remote_state.core_infra.outputs.out_kubernetes_basic_compute_type
    kubernetes_nodepool_vm_min_system     = data.terraform_remote_state.core_infra.outputs.out_kubernetes_min_system_instances
    kubernetes_nodepool_vm_max_system     = data.terraform_remote_state.core_infra.outputs.out_kubernetes_max_system_instances
    kubernetes_nodepool_vm_services_min   = data.terraform_remote_state.core_infra.outputs.out_kubernetes_min_services_instances
    kubernetes_nodepool_vm_services_max   = data.terraform_remote_state.core_infra.outputs.out_kubernetes_max_services_instances
    kubernetes_nodepool_vm_monitoring_min = data.terraform_remote_state.core_infra.outputs.out_kubernetes_min_monitoring_instances
    kubernetes_nodepool_vm_monitoring_max = data.terraform_remote_state.core_infra.outputs.out_kubernetes_max_monitoring_instances
    kubernetes_nodepool_vm_highmemory_min = data.terraform_remote_state.core_infra.outputs.out_kubernetes_min_highmemory_compute_instances
    kubernetes_nodepool_vm_highmemory_max = data.terraform_remote_state.core_infra.outputs.out_kubernetes_max_highmemory_compute_instances
    kubernetes_nodepool_vm_highcpu_min    = data.terraform_remote_state.core_infra.outputs.out_kubernetes_min_highcpu_compute_instances
    kubernetes_nodepool_vm_highcpu_max    = data.terraform_remote_state.core_infra.outputs.out_kubernetes_max_highcpu_compute_instances
    kubernetes_nodepool_vm_database_min   = data.terraform_remote_state.core_infra.outputs.out_kubernetes_min_db_instances
    kubernetes_nodepool_vm_database_max   = data.terraform_remote_state.core_infra.outputs.out_kubernetes_max_db_instances
    kubernetes_nodepool_vm_basic_min      = data.terraform_remote_state.core_infra.outputs.out_kubernetes_min_basic_compute_instances
    kubernetes_nodepool_vm_basic_max      = data.terraform_remote_state.core_infra.outputs.out_kubernetes_max_basic_compute_instances

    argocd_deploy       = var.argocd_deploy
    argocd_version      = var.argocd_helm_chart_version
    vault_deploy        = var.vault_deploy
    vault_version       = var.vault_helm_chart_version
    sops_deploy         = var.vault_secrets_operator_deploy
    sops_version        = var.vault_secrets_operator_helm_chart_version
    certmanager_deploy  = true
    certmanager_version = var.cert_manager_version
    prom_deploy         = true
    prom_version        = var.prom_stack_version
    loki_deploy         = var.loki_deploy
    loki_version        = var.loki_helm_chart_version
    nginx_deploy        = var.nginx_deploy
    nginx_version       = var.nginx_ingress_version
    grafana_deploy      = true
  }
}
