locals {
  namespace = "keycloak"

  pvc_name = "${local.namespace}-pvc"
  pv_name  = "${local.namespace}-pv"

  keycloak_values = {
    "NAMESPACE"                          = local.namespace
    "SECRET"                             = "keycloak-config"
    "ADMIN_USER"                         = var.keycloak_admin_user
    "ADMIN_PASSWORD_SECRET_KEY"          = "keycloak_admin_password"
    "INGRESS_HOSTNAME"                   = var.keycloak_ingress_hostname
    "POSTGRES_USER"                      = var.keycloak_postgres_user
    "POSTGRES_PASSWORD_SECRET_KEY"       = "keycloak_postgres_password"
    "POSTGRES_ADMIN_PASSWORD_SECRET_KEY" = "keycloak_postgres_admin_password"
    "PVC_NAME"                           = var.is_bare_metal ? local.pvc_name : ""
    "STORAGE_CLASS"                      = var.provisioner
  }
}

resource "kubernetes_namespace" "keycloak_namespace" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "keycloak-postgresql" {
  name       = "keycloak-postgresql"
  repository = var.postgres_helm_repo
  chart      = var.postgres_helm_chart
  version    = var.postgres_helm_chart_version
  namespace  = local.namespace

  values = [
    templatefile("${path.module}/values-postgresql.yaml", local.keycloak_values)
  ]

  depends_on = [kubernetes_namespace.keycloak_namespace]
}

resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = var.keycloak_helm_repo
  chart      = var.keycloak_helm_chart
  version    = var.keycloak_helm_chart_version
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
    name      = "keycloak-config"
    namespace = local.namespace
    labels = {
      "app" = "keycloak"
    }
  }

  data = {
    keycloak_admin_user              = local.keycloak_values.ADMIN_USER
    keycloak_admin_password          = random_password.keycloak_admin_password.result
    keycloak_postgres_user           = local.keycloak_values.POSTGRES_USER
    keycloak_postgres_password       = random_password.keycloak_postgresql_password.result
    keycloak_postgres_admin_password = random_password.keycloak_postgresql_admin_password.result
  }

  type = "Opaque"
}
