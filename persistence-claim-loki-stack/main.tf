locals {
  disk_loki_name    = "disk-loki-core"
}

resource "kubernetes_persistent_volume_claim" "loki_master" {
  metadata {
    name      = "pvc-${local.disk_loki_name}"
    namespace = var.pvc_loki_stack_namespace
  }
  spec {
    access_modes       = [var.pvc_loki_storage_accessmode]
    storage_class_name = var.pvc_loki_storage_class_name
    resources {
      requests = {
        storage = var.pvc_loki_storage_gbi
      }
    }
    volume_name = "pv-${local.disk_loki_name}"
  }
}
