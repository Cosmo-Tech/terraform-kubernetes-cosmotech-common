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
    "LOKI_PVC_NAME"                    = var.provisioner == "local-path" ? "${var.resources[0].name}-pvc" : ""
    "GRAFANA_PVC_NAME"                 = var.provisioner == "local-path" ? "${var.resources[1].name}-pvc" : ""
    "GRAFANA_IMAGE_TAG"                = var.grafana_loki_compatibility_image_tag
    "STORAGE_CLASS"                    = var.provisioner == "local-path" ? "-" : var.provisioner
  }
  values = var.is_bare_metal ? "values-vanilla" : "values-azure"
}

resource "helm_release" "loki" {
  name         = var.loki_release_name
  repository   = var.helm_repo_url
  chart        = var.helm_chart
  namespace    = var.monitoring_namespace
  reset_values = true
  values = [
    templatefile("${path.module}/${local.values}.yaml", local.values_loki)
  ]
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