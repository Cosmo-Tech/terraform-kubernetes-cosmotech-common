
variable "velero_deploy" {
  type = bool
}

variable "velero_init_container_image" {
  type = string
}

variable "velero_blob_storage_name" {
  type = string
}

variable "velero_cloud_provider" {
  type = string
}

variable "velero_bucket_name" {
  type = string
}

variable "velero_storage_account_name" {
  type = string
}

variable "velero_storage_account_resource_name" {
  type = string
}

variable "velero_bakcup_client_id" {
  type = string
}

variable "velero_bakcup_client_secret" {
  type = string
}

variable "velero_backup_resource_group_cluster" {
  type = string
}

variable "velero_storage_account_access_key" {
  type = string
}

variable "velero_release_name" {
  type = string
}

variable "velero_helm_repo_url" {
  type = string
}

variable "velero_helm_chart" {
  type = string
}

variable "velero_helm_chart_version" {
  type = string
}

variable "velero_namespace" {
  type = string
}

variable "velero_azure_subcription_id" {
  type = string
}

variable "velero_azure_tenant_id" {
  type = string
}