locals {
  velero_storage_key          = var.velero_storage_account_access_key == "" ? data.kubernetes_secret.velero_storage.data.password : var.velero_storage_account_access_key
  velero_storage_name         = var.velero_storage_account_name == "" ? data.kubernetes_secret.velero_storage.data.name : var.velero_storage_account_name
  velero_resource_aks_managed = var.velero_backup_resource_group_cluster == "" ? data.kubernetes_secret.velero_storage.data.resource_aks_managed : var.velero_backup_resource_group_cluster
  velero_client_id            = var.velero_backup_client_id == "" ? data.kubernetes_secret.network_conf.data.client_id : var.velero_backup_client_id
  velero_client_secret        = var.velero_backup_client_secret == "" ? data.kubernetes_secret.network_conf.data.password : var.velero_backup_client_secret
  velero_locals_values = {
    "AZURE_SUBSCRIPTION_ID"               = var.velero_azure_subcription_id
    "AZURE_TENANT_ID"                     = var.velero_azure_tenant_id
    "VELERO_INIT_CONTAINER_IMAGE"         = var.velero_init_container_image
    "VELERO_BLOB_STORAGE_NAME"            = var.velero_blob_storage_name
    "VELERO_CLOUD_PROVIDER"               = var.velero_cloud_provider
    "VELERO_BUCKET_NAME"                  = var.velero_bucket_name
    "STORAGE_ACCOUNT_NAME"                = local.velero_storage_name
    "STORAGE_ACCOUNT_RESOURCE_NAME"       = var.velero_storage_account_resource_name
    "AZURE_BACKUP_CLIENT_ID"              = local.velero_client_id
    "AZURE_BACKUP_CLIENT_SECRET"          = local.velero_client_secret
    "AZURE_BACKUP_RESOURCE_GROUP_CLUSTER" = local.velero_resource_aks_managed
    "AZURE_STORAGE_ACCOUNT_ACCESS_KEY"    = local.velero_storage_key
  }
}

resource "kubernetes_namespace" "velero_namespace" {
  metadata {
    name = var.velero_namespace
  }
}

data "kubernetes_secret" "velero_storage" {
  metadata {
    name      = "velero-storage"
    namespace = "default"
  }
}

data "kubernetes_secret" "network_conf" {
  metadata {
    name      = "network-client-secret"
    namespace = "default"
  }
}

resource "helm_release" "velero" {
  name         = var.velero_release_name
  repository   = var.velero_helm_repo_url
  chart        = var.velero_helm_chart
  version      = var.velero_helm_chart_version
  namespace    = var.velero_namespace
  reset_values = true
  timeout      = 600

  values = [
    templatefile("${path.module}/values.yaml", local.velero_locals_values)
  ]

  depends_on = [
    kubernetes_namespace.velero_namespace
  ]
}
