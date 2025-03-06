locals {
  local_redis_admin_password = var.redis_admin_password == "" ? random_password.redis_admin_password.result : var.redis_admin_password
  local_prom_admin_password  = var.prom_admin_password == "" ? random_password.prom_admin_password.result : var.prom_admin_password

  values_prometheus_stack = {
    "MONITORING_NAMESPACE"          = var.monitoring_namespace
    "COSMOTECH_API_DNS_NAME"        = var.api_dns_name
    "TLS_SECRET_NAME"               = var.tls_secret_name
    "REDIS_HOST"                    = "cosmotechredis-${var.redis_host_namespace}-master.${var.redis_host_namespace}.svc.cluster.local"
    "REDIS_PORT"                    = var.redis_port
    "REDIS_ADMIN_PASSWORD"          = local.local_redis_admin_password
    "ALERT_MANAGER_RESOURCES"       = jsonencode(var.prom_alert_manager_resources)
    "PROM_ADMIN_PASSWORD"           = local.local_prom_admin_password
    "PROM_REPLICAS_NUMBER"          = var.prom_replicas_number
    "PROM_STORAGE_RESOURCE_REQUEST" = var.prom_storage_resource_request
    "PROM_STORAGE_CLASS_NAME"       = var.prom_storage_class_name
    "PROM_RESOURCES"                = jsonencode(var.prom_resources)
    "PROM_RETENTION"                = var.prom_retention
    "PROM_PV_EXISTING_NAME"        = var.prom_pv_existing_name
  }
}

resource "kubernetes_namespace" "monitoring_namespace" {
  metadata {
    name = var.monitoring_namespace
  }
  timeouts {
    delete = "5m"
  }
}

resource "random_password" "redis_admin_password" {
  length  = 30
  special = false
}

resource "random_password" "prom_admin_password" {
  length  = 30
  special = false
}

resource "helm_release" "prometheus-stack" {
  name             = var.helm_release_name
  repository       = var.helm_repo_url
  chart            = var.helm_chart
  version          = var.prometheus_stack_version
  namespace        = var.monitoring_namespace
  create_namespace = false

  timeout      = 600
  reuse_values = true

  values = [
    templatefile("${path.module}/values.yaml", local.values_prometheus_stack)
  ]

  depends_on = [
    kubernetes_namespace.monitoring_namespace
  ]
}

resource "kubernetes_secret" "prom_first_datasource" {
  metadata {
    name      = "prom-redis-datasource"
    namespace = "default"
  }
  data = {
    password = random_password.redis_admin_password.result
  }
}
