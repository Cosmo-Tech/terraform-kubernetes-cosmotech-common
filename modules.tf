module "create-prometheus-stack" {
  source = "./create-prometheus-stack"

  count = var.prometheus_stack_deploy ? 1 : 0

  redis_host_namespace          = var.prom_redis_host_namespace
  monitoring_namespace          = var.monitoring_namespace
  api_dns_name                  = var.api_dns_name
  tls_secret_name               = local.tls_secret_name
  redis_admin_password          = var.redis_admin_password
  prom_admin_password           = var.prom_admin_password
  prom_cpu_mem_limits           = var.prom_cpu_mem_limits
  prom_cpu_mem_request          = var.prom_cpu_mem_request
  helm_chart                    = var.prom_helm_chart
  helm_repo_url                 = var.prom_helm_repo_url
  helm_release_name             = var.prom_helm_release_name
  prometheus_stack_version      = var.prom_stack_version
  prom_storage_class_name       = var.prom_storage_class_name
  prom_replicas_number          = var.prom_replicas_number
  redis_port                    = var.prom_redis_port
  prom_retention                = var.prom_retention
  prom_storage_resource_request = var.prom_storage_resource_request

}

module "loki" {
  source = "./create-loki"

  count = var.loki_deploy ? 1 : 0

  monitoring_namespace                 = var.monitoring_namespace
  loki_release_name                    = var.loki_release_name
  loki_persistence_memory              = var.loki_persistence_memory
  loki_retention_period                = var.loki_retention_period
  helm_repo_url                        = var.loki_helm_repo_url
  helm_chart                           = var.loki_helm_chart
  loki_max_entries_limet_per_query     = var.loki_max_entries_limet_per_query
  grafana_loki_compatibility_image_tag = var.grafana_loki_compatibility_image_tag
  is_bare_metal                        = var.is_bare_metal
  provisioner                          = var.loki_provisioner
  resources                            = var.loki_resources

  depends_on = [module.create-prometheus-stack]
}

module "create-ingress-nginx" {
  source = "./create-ingress-nginx"

  count = var.nginx_deploy ? 1 : 0

  is_bare_metal           = var.is_bare_metal
  monitoring_namespace    = var.monitoring_namespace
  ingress_nginx_version   = var.nginx_ingress_version
  loadbalancer_ip         = var.publicip_address
  publicip_resource_group = var.publicip_resource_group
  helm_release_name       = var.nginx_helm_release_name
  helm_repo_url           = var.nginx_helm_repo_url
  nginx_namespace         = var.nginx_namespace
  tls_secret_name         = local.tls_secret_name

  depends_on = [module.loki]
}

module "cert-manager" {
  source = "./create-cert-manager"

  count = var.tls_certificate_type == "let_s_encrypt" ? 1 : 0

  tls_certificate_type     = var.tls_certificate_type
  monitoring_namespace     = var.monitoring_namespace
  cluster_issuer_email     = var.cluster_issuer_email
  cluster_issuer_name      = var.cluster_issuer_name
  tls_secret_name          = local.tls_secret_name
  api_dns_name             = var.api_dns_name
  certificate_cert_content = var.certificate_cert_content
  certificate_key_content  = var.certificate_key_content
  is_bare_metal            = var.is_bare_metal
  helm_release_name        = var.cert_helm_release_name
  helm_repo_url            = var.cert_helm_repo_url
  cluster_issuer_server    = var.cluster_issuer_server
  cert_namespace           = var.cert_namespace
  cert_manager_version     = var.cert_manager_version

  depends_on = [module.create-ingress-nginx]
}


module "keycloak" {
  source = "./create-keycloak"

  count = var.keycloak_deploy ? 1 : 0

  keycloak_ingress_hostname   = var.keycloak_ingress_hostname
  is_bare_metal               = var.is_bare_metal
  provisioner                 = var.keycloack_provisioner
  keycloak_admin_user         = var.keycloak_admin_user
  keycloak_helm_chart         = var.keycloak_helm_chart
  keycloak_helm_chart_version = var.keycloak_helm_chart_version
  keycloak_helm_repo          = var.keycloak_helm_repo
  keycloak_postgres_user      = var.keycloak_postgres_user
  postgres_helm_chart         = var.postgres_helm_chart
  postgres_helm_chart_version = var.postgres_helm_chart_version
  postgres_helm_repo          = var.postgres_helm_repo

  depends_on = [module.cert-manager]
}

module "create_vault" {
  source = "./create_vault"

  count = var.vault_deploy ? 1 : 0

  namespace             = var.vault_namespace
  helm_repo_url         = var.vault_helm_repo_url
  helm_chart            = var.vault_helm_chart
  helm_chart_version    = var.vault_helm_chart_version
  helm_release_name     = var.vault_helm_release_name
  vault_replicas        = var.vault_replicas
  vault_secret_name     = var.vault_secret_name
  vault_ingress_enabled = var.vault_ingress_enabled
  vault_dns_name        = var.api_dns_name
  start_aks_minutes     = var.auto_restart_start_minutes
  start_aks_hours       = var.auto_restart_start_hours
  auto_restart_deploy   = var.auto_restart_deploy

  depends_on = [module.cert-manager]
}

module "create_argocd" {
  source = "./create_argocd"

  count = var.argocd_deploy ? 1 : 0

  namespace                      = var.argocd_namespace
  helm_repo_url                  = var.argocd_helm_repo_url
  helm_chart                     = var.argocd_helm_chart
  helm_chart_version             = var.argocd_helm_chart_version
  helm_release_name              = var.argocd_helm_release_name
  replicas                       = var.argocd_replicas
  create_ingress                 = var.argocd_create_ingress
  argocd_project                 = var.argocd_project
  argocd_repositories            = var.argocd_repositories
  argocd_dns_name                = var.api_dns_name
  argocd_setup_job_image_version = var.argocd_setup_job_image_version

  depends_on = [module.create_vault]
}

module "create_vault_secrets_operator" {
  source = "./create-vault-secrets-operator"

  count = var.vault_secrets_operator_deploy ? 1 : 0

  namespace          = var.vault_secrets_operator_namespace
  helm_repo_url      = var.vault_secrets_operator_helm_repo_url
  helm_chart         = var.vault_secrets_operator_helm_chart
  helm_chart_version = var.vault_secrets_operator_helm_chart_version
  helm_release_name  = var.vault_secrets_operator_helm_release_name
  vault_address      = var.vault_secrets_operator_vault_address
  replicas           = var.vault_secrets_operator_replicas
  vault_namespace    = var.vault_namespace

  depends_on = [module.create_vault]
}

/*
module "create_tekton" {
  source = "./create-tekton"
  #count = var.tekton_deploy ? 1 : 0
}
*/

module "create_tekton" {
  source = "./create-tekton"

  namespace                         = var.tekton_namespace
  helm_repo_url                     = var.tekton_helm_repo_url
  helm_chart                        = var.tekton_helm_chart
  helm_chart_version                = var.tekton_helm_chart_version
  helm_release_name                 = var.tekton_helm_release_name
  dashboard_helm_repo_url           = var.tekton_dashboard_helm_repo_url
  dashboard_helm_chart              = var.tekton_dashboard_helm_chart
  dashboard_helm_chart_version      = var.tekton_dashboard_helm_chart_version
  dashboard_helm_release_name       = var.tekton_dashboard_helm_release_name
  triggers_helm_repo_url           = var.tekton_triggers_helm_repo_url
  triggers_helm_chart              = var.tekton_triggers_helm_chart
  triggers_helm_chart_version      = var.tekton_triggers_helm_chart_version
  triggers_helm_release_name       = var.tekton_triggers_helm_release_name
  interceptors_helm_repo_url           = var.tekton_interceptors_helm_repo_url
  interceptors_helm_chart              = var.tekton_interceptors_helm_chart
  interceptors_helm_chart_version      = var.tekton_interceptors_helm_chart_version
  interceptors_helm_release_name       = var.tekton_interceptors_helm_release_name

}