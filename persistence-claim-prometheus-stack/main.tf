locals {
  disk_grafana_name = "disk-grafana-core"
}

resource "kubernetes_persistent_volume_claim" "grafana_master" {
  metadata {
    name      = "pvc-${local.disk_grafana_name}"
    namespace = var.monitoring_namespace
  }
  spec {
    access_modes       = [var.pvc_grafana_storage_accessmode]
    storage_class_name = var.pvc_grafana_storage_class_name
    resources {
      requests = {
        storage = var.pvc_grafana_storage_gbi
      }
    }
    volume_name = "pv-${local.disk_grafana_name}"
  }
}