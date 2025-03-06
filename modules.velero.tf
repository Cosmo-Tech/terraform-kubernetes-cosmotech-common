module "deploy_velero" {
  source = "./create_velero"

  count = var.velero_deploy ? 1 : 0

  velero_init_container_image          = var.velero_init_container_image
  velero_blob_storage_name             = var.velero_blob_storage_name
  velero_cloud_provider                = var.velero_cloud_provider
  velero_bucket_name                   = var.velero_bucket_name
  velero_storage_account_name          = var.velero_storage_account_name
  velero_storage_account_resource_name = var.velero_storage_account_resource_name
  velero_backup_client_id              = var.velero_backup_client_id
  velero_backup_client_secret          = var.velero_backup_client_secret
  velero_backup_resource_group_cluster = var.velero_backup_resource_group_cluster
  velero_storage_account_access_key    = var.velero_storage_account_access_key
  velero_release_name                  = var.velero_release_name
  velero_helm_repo_url                 = var.velero_helm_repo_url
  velero_helm_chart                    = var.velero_helm_chart
  velero_helm_chart_version            = var.velero_helm_chart_version
  velero_namespace                     = var.velero_namespace
  velero_azure_subcription_id          = var.velero_azure_subcription_id
  velero_azure_tenant_id               = var.velero_azure_tenant_id
}