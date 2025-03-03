locals {
  pvc_name = "${var.keycloak_namespace}-pvc"
  pv_name  = "${var.keycloak_namespace}-pv"

  keycloak_values = {
    "NAMESPACE"                          = var.keycloak_namespace
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

resource "helm_release" "keycloak-postgresql" {
  name       = "keycloak-postgresql"
  repository = var.postgres_helm_repo
  chart      = var.postgres_helm_chart
  version    = var.postgres_helm_chart_version
  namespace  = var.keycloak_namespace

  values = [
    templatefile("${path.module}/values-postgresql.yaml", local.keycloak_values)
  ]
}

resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = var.keycloak_helm_repo
  chart      = var.keycloak_helm_chart
  version    = var.keycloak_helm_chart_version
  namespace  = var.keycloak_namespace

  values = [
    templatefile("${path.module}/values-keycloak.yaml", local.keycloak_values)
  ]

  depends_on = [helm_release.keycloak-postgresql]
}