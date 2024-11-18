locals {
  velero_locals_values = {
    "AZURE_SUBSCRIPTION_ID"               = var.velero_azure_subcription_id
    "AZURE_TENANT_ID"                     = var.velero_azure_tenant_id
    "VELERO_INIT_CONTAINER_IMAGE"         = var.velero_init_container_image
    "VELERO_BLOB_STORAGE_NAME"            = var.velero_blob_storage_name
    "VELERO_CLOUD_PROVIDER"               = var.velero_cloud_provider
    "VELERO_BUCKET_NAME"                  = var.velero_bucket_name
    "STORAGE_ACCOUNT_NAME"                = var.velero_storage_account_name
    "STORAGE_ACCOUNT_RESOURCE_NAME"       = var.velero_storage_account_resource_name
    "AZURE_BACKUP_CLIENT_ID"              = var.velero_bakcup_client_id
    "AZURE_BACKUP_CLIENT_SECRET"          = var.velero_bakcup_client_secret
    "AZURE_BACKUP_RESOURCE_GROUP_CLUSTER" = var.velero_backup_resource_group_cluster
    "AZURE_STORAGE_ACCOUNT_ACCESS_KEY"    = var.velero_storage_account_access_key
  }
}

resource "kubernetes_namespace" "velero_namespace" {
  metadata {
    name = var.velero_namespace
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
