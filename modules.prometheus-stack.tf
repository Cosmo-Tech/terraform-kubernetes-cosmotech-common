module "create-prometheus-stack" {
  source = "./create-prometheus-stack"

  count = var.prometheus_stack_deploy ? 1 : 0

  redis_host_namespace           = var.prom_redis_host_namespace
  monitoring_namespace           = var.monitoring_namespace
  api_dns_name                   = var.api_dns_name
  tls_secret_name                = local.tls_secret_name
  redis_admin_password           = var.redis_admin_password
  prom_admin_password            = var.prom_admin_password
  helm_chart                     = var.prom_helm_chart
  helm_repo_url                  = var.prom_helm_repo_url
  helm_release_name              = var.prom_helm_release_name
  prometheus_stack_version       = var.prom_stack_version
  prom_storage_class_name        = var.prom_storage_class_name
  prom_replicas_number           = var.prom_replicas_number
  redis_port                     = var.prom_redis_port
  prom_retention                 = var.prom_retention
  prom_storage_resource_request  = var.prom_storage_resource_request
  prom_pv_existing_name          = var.prom_pv_existing_name
  prom_alert_manager_resources   = var.prom_alert_manager_resources
  prom_resources                 = var.prom_resources
  pvc_grafana_storage_class_name = var.pvc_grafana_storage_class_name
  pvc_grafana_storage_gbi        = var.pvc_grafana_storage_gbi
}

module "deploy-pvc-prometheus-stack" {
  source = "./persistence-claim-prometheus-stack"

  count = var.pvc_prometheus_stack_deploy ? 1 : 0

  monitoring_namespace           = var.monitoring_namespace
  pvc_grafana_storage_accessmode = var.pvc_grafana_storage_accessmode
  pvc_grafana_storage_class_name = var.pvc_grafana_storage_class_name
  pvc_grafana_storage_gbi        = var.pvc_grafana_storage_gbi

}