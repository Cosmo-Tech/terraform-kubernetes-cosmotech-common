locals {
  values_loki = {
    "MONITORING_NAMESPACE"             = var.monitoring_namespace
    "LOKI_RETENTION_PERIOD"            = var.loki_retention_period
    "LOKI_PERSISTENCE_MEMORY"          = var.loki_persistence_memory
    "LOKI_MAX_ENTRIES_LIMIT_PER_QUERY" = var.loki_max_entries_limet_per_query
    "LOKI_PVC_NAME"                    = "pvc-disk-loki-core"
    "LOKI_STORAGE_CLASS"               = var.pvc_loki_storage_class_name
    "GRAFANA_IMAGE_TAG"                = var.grafana_loki_compatibility_image_tag
  }
  values = var.is_bare_metal ? "values-vanilla" : "values-azure"
}

resource "time_sleep" "wait_termination" {
  destroy_duration = "10s"
}

resource "helm_release" "loki" {
  name         = var.loki_release_name
  repository   = var.loki_helm_repo_url
  chart        = var.loki_helm_chart
  namespace    = var.monitoring_namespace
  version      = var.loki_helm_chart_version
  reset_values = true
  values = [
    templatefile("${path.module}/${local.values}.yaml", local.values_loki)
  ]
  depends_on = [time_sleep.wait_termination]
}

resource "kubectl_manifest" "role" {
  count           = var.is_bare_metal ? 1 : 0
  validate_schema = false
  yaml_body       = templatefile("${path.module}/role.yaml", local.values_loki)
}

resource "kubectl_manifest" "rolebinding" {
  count           = var.is_bare_metal ? 1 : 0
  validate_schema = false
  yaml_body       = templatefile("${path.module}/rolebinding.yaml", local.values_loki)
}
