module "loki" {
  source = "./create-loki"

  count = var.loki_deploy ? 1 : 0

  monitoring_namespace                 = var.monitoring_namespace
  loki_release_name                    = var.loki_release_name
  loki_persistence_memory              = var.loki_persistence_memory
  loki_retention_period                = var.loki_retention_period
  loki_helm_repo_url                   = var.loki_helm_repo_url
  loki_helm_chart                      = var.loki_helm_chart
  loki_helm_chart_version              = var.loki_helm_chart_version
  loki_max_entries_limet_per_query     = var.loki_max_entries_limet_per_query
  grafana_loki_compatibility_image_tag = var.grafana_loki_compatibility_image_tag
  is_bare_metal                        = var.is_bare_metal
  resources                            = var.loki_resources
  pvc_loki_storage_class_name          = var.pvc_loki_storage_class_name

  depends_on = [module.create-prometheus-stack]
}

module "deploy-pvc-loki-stack" {
  source = "./persistence-claim-loki-stack"

  count = var.pvc_loki_stack_deploy ? 1 : 0

  pvc_loki_stack_namespace    = var.pvc_loki_stack_namespace
  pvc_loki_storage_accessmode = var.pvc_loki_storage_accessmode
  pvc_loki_storage_class_name = var.pvc_loki_storage_class_name
  pvc_loki_storage_gbi        = var.pvc_loki_storage_gbi

}