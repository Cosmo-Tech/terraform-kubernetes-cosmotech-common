locals {
  namespace          = "keycloak"
  keycloak_version   = "21.3.1"
  postgresql_version = "15.5.1"

  pvc_name = "${local.namespace}-pvc"
  pv_name  = "${local.namespace}-pv"

  keycloak_values = {
    "NAMESPACE" = local.namespace
    "SECRET" = "keycloak-config"
    "ADMIN_USER" = var.keycloak_admin_user
    "ADMIN_PASSWORD_SECRET_KEY" = "keycloak_admin_password"
    "INGRESS_HOSTNAME" = var.keycloak_ingress_hostname
    "POSTGRES_USER" = var.keycloak_postgres_user
    "POSTGRES_PASSWORD_SECRET_KEY" = "keycloak_postgres_password"
    "POSTGRES_ADMIN_PASSWORD_SECRET_KEY" = "keycloak_postgres_admin_password"
    "PVC_NAME" = var.is_bare_metal ? local.pvc_name : ""
  }
}

resource "kubernetes_namespace" "keycloak_namespace" {
    metadata {
        name = local.namespace
    }
}

resource "kubernetes_persistent_volume_v1" "postgresql-pv" {
  count = var.is_bare_metal ? 1 : 0
  metadata {
    name = local.pv_name
    labels = {
      "cosmotech.com/service" = "keycloak"
    }
  }
  spec {
    storage_class_name = ""
    access_modes       = ["ReadWriteOnce"]
    claim_ref {
      name      = local.pvc_name
      namespace = local.namespace
    }
    capacity = {
      storage = "4Gi"
    }
    persistent_volume_source {
      local {
        path = "/mnt/postgres-storage"
      }
    }
    persistent_volume_reclaim_policy = "Retain"

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "cosmotech.com/tier"
            operator = "In"
            values   = ["services"]
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "postgres-pvc" {
  count = var.is_bare_metal ? 1 : 0 
  metadata {
    name      = local.pvc_name
    namespace = local.namespace
  }
  spec {
    storage_class_name = ""
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "4Gi"
      }
    }
    volume_name = local.pv_name
  }
}

resource "helm_release" "keycloak-postgresql" {
    name       = "keycloak-postgresql"
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "postgresql"
    version    = local.postgresql_version
    namespace  = local.namespace

    values = [
        templatefile("${path.module}/values-postgresql.yaml", local.keycloak_values)
    ]

    depends_on = [kubernetes_namespace.keycloak_namespace]
}

resource "helm_release" "keycloak" {
    name       = "keycloak"
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "keycloak"
    version    = local.keycloak_version
    namespace  = local.namespace
    
    values = [
        templatefile("${path.module}/values-keycloak.yaml", local.keycloak_values)
    ]

    depends_on = [kubernetes_namespace.keycloak_namespace, helm_release.keycloak-postgresql]
}

resource "random_password" "keycloak_admin_password" {
  length  = 30
  special = false
}

resource "random_password" "keycloak_postgresql_password" {
  length  = 30
  special = false
}

resource "random_password" "keycloak_postgresql_admin_password" {
  length  = 30
  special = false
}

resource "kubernetes_secret" "keycloak_config" {
  metadata {
    name = "keycloak-config"
    namespace = local.namespace
    labels = {
      "app" = "keycloak"
    }
  }

  data = {
    keycloak_admin_user     = local.keycloak_values.ADMIN_USER
    keycloak_admin_password = random_password.keycloak_admin_password.result
    keycloak_postgres_user  = local.keycloak_values.POSTGRES_USER
    keycloak_postgres_password  = random_password.keycloak_postgresql_password.result
    keycloak_postgres_admin_password  = random_password.keycloak_postgresql_admin_password.result
  }

  type = "Opaque"
}
