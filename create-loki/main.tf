terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
  }
}

locals {
  values_loki = {
    "MONITORING_NAMESPACE"             = var.monitoring_namespace
    "LOKI_RETENTION_PERIOD"            = var.loki_retention_period
    "LOKI_PERSISTENCE_MEMORY"          = var.loki_persistence_memory
    "LOKI_MAX_ENTRIES_LIMIT_PER_QUERY" = var.loki_max_entries_limet_per_query
    "NAMESPACE"                        = var.namespace
    "GRAFANA_IMAGE_TAG"                = var.grafana_loki_compatibility_image_tag
  }
}

resource "helm_release" "promtail" {
  name         = var.promtail_release_name
  repository   = var.helm_repo_url
  chart        = var.promtail_helm_chart
  namespace    = var.monitoring_namespace
  version      = var.promtail_chart_version
  reset_values = true
  values = [
    templatefile("${path.module}/values-promtail.yaml", local.values_loki)
  ]
}

resource "helm_release" "loki" {
  name         = var.loki_release_name
  repository   = var.helm_repo_url
  chart        = var.loki_helm_chart
  namespace    = var.monitoring_namespace
  version      = var.loki_chart_version
  reset_values = true
  values = [
    templatefile("${path.module}/values-loki.yaml", local.values_loki)
  ]
}

resource "kubectl_manifest" "role" {
  validate_schema = false
  yaml_body       = templatefile("${path.module}/role.yaml", local.values_loki)
}

resource "kubectl_manifest" "rolebinding" {
  validate_schema = false
  yaml_body       = templatefile("${path.module}/rolebinding.yaml", local.values_loki)
}