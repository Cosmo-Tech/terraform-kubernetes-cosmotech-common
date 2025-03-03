locals {
  disk_name  = "disk-postgres-core-keycloak"
}

resource "kubernetes_persistent_volume_claim" "postgres_keycloak_master" {
  metadata {
    name      = "pvc-${local.disk_name}"
    namespace = var.keycloak_namespace
  }
  spec {
    access_modes = [var.pvc_keycloak_postgres_storage_accessmode]
    storage_class_name = var.pvc_keycloak_postgres_storage_class_name
    resources {
      requests = {
        storage = var.pvc_keycloak_postgres_storage_gbi
      }
    }
    volume_name = "pv-${local.disk_name}"
  }
}