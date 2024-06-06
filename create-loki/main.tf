locals {
  values_loki = {
    "MONITORING_NAMESPACE"             = var.monitoring_namespace
    "LOKI_RETENTION_PERIOD"            = var.loki_retention_period
    "LOKI_PERSISTENCE_MEMORY"          = var.loki_persistence_memory
    "LOKI_MAX_ENTRIES_LIMIT_PER_QUERY" = var.loki_max_entries_limet_per_query
    "LOKI_PVC_NAME"                    = var.provisioner == "local-path" ? "${var.resources[0].name}-pvc" : ""
    "GRAFANA_PVC_NAME"                 = var.provisioner == "local-path" ? "${var.resources[1].name}-pvc" : ""
    "NAMESPACE"                        = var.namespace
    "GRAFANA_IMAGE_TAG"                = var.grafana_loki_compatibility_image_tag
    "STORAGE_CLASS"                    = var.provisioner == "local-path" ? "-" : var.provisioner
  }
  values = var.is_bare_metal ? "values-vanilla" : "values-azure"
}

resource "kubernetes_persistent_volume_v1" "loki-pv" {
  count = var.is_bare_metal && var.provisioner == "local-path" ? length(var.resources) : 0
  metadata {
    name   = "${var.resources[count.index].name}-pv"
    labels = var.resources[count.index].labels
  }

  spec {
    capacity = {
      storage = var.resources[count.index].storage
    }
    access_modes = var.resources[count.index].access_modes

    persistent_volume_source {
      local {
        path = var.resources[count.index].path
      }
    }
    persistent_volume_reclaim_policy = "Retain"
    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "cosmotech.com/tier"
            operator = "In"
            values   = ["monitoring"]
          }
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = var.is_bare_metal && var.provisioner == "local-path"
      error_message = "This resource is only available in a bare metal environment and for local-path provisioner."
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "loki-pvc" {
  count = var.is_bare_metal ? length(var.resources) : 0

  metadata {
    name      = "${var.resources[count.index].name}-pvc"
    namespace = var.monitoring_namespace
  }

  spec {
    storage_class_name = ""
    access_modes       = var.resources[count.index].access_modes
    resources {
      requests = {
        storage = var.resources[count.index].storage
      }
    }
    volume_name = "${var.resources[count.index].name}-pv"
  }

  lifecycle {
    precondition {
      condition     = var.is_bare_metal && var.provisioner == "local-path"
      error_message = "This resource is only available in a bare metal environment and for local-path provisioner."
    }
  }
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

  depends_on = [kubernetes_persistent_volume_claim_v1.loki-pvc, kubernetes_persistent_volume_v1.loki-pv]
}
