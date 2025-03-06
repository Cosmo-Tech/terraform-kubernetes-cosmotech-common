module "keycloak" {
  source = "./create-keycloak"

  count = var.keycloak_deploy ? 1 : 0

  keycloak_namespace                  = var.keycloak_namespace
  keycloak_ingress_hostname           = var.keycloak_ingress_hostname
  is_bare_metal                       = var.is_bare_metal
  provisioner                         = var.keycloack_provisioner
  keycloak_admin_user                 = var.keycloak_admin_user
  keycloak_helm_chart                 = var.keycloak_helm_chart
  keycloak_helm_chart_version         = var.keycloak_helm_chart_version
  keycloak_helm_repo                  = var.keycloak_helm_repo
  keycloak_postgres_user              = var.keycloak_postgres_user
  postgres_helm_chart                 = var.postgres_helm_chart
  postgres_helm_chart_version         = var.postgres_helm_chart_version
  postgres_helm_repo                  = var.postgres_helm_repo
  pvc_postgres_keycloak_existing_name = var.pvc_postgres_keycloak_existing_name

  depends_on = [module.cert-manager]
}


module "deploy-pvc-postgres-keycloak" {
  source = "./persistence-claim-postgres-keycloak"

  count = var.pvc_keycloak_postgres_deploy ? 1 : 0

  keycloak_namespace                       = var.keycloak_namespace
  pvc_keycloak_postgres_storage_gbi        = var.pvc_keycloak_postgres_storage_gbi
  pvc_keycloak_postgres_storage_class_name = var.pvc_keycloak_postgres_storage_class_name
  pvc_keycloak_postgres_storage_accessmode = var.pvc_keycloak_postgres_storage_accessmode

}