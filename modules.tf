module "create-ingress-nginx" {
  source = "./create-ingress-nginx"

  is_bare_metal           = var.is_bare_metal
  monitoring_namespace    = var.monitoring_namespace
  ingress_nginx_version   = var.ingress_nginx_version
  loadbalancer_ip         = var.publicip_address
  tls_secret_name         = local.tls_secret_name
  publicip_resource_group = var.publicip_resource_group

}

module "create-prometheus-stack" {
  source = "./create-prometheus-stack"

  count                         = var.create_prometheus_stack ? 1 : 0
  redis_host_namespace          = var.prom_redis_host_namespace
  monitoring_namespace          = var.monitoring_namespace
  api_dns_name                  = var.api_dns_name
  tls_secret_name               = local.tls_secret_name
  redis_admin_password          = random_password.redis_admin_password.result
  prom_admin_password           = random_password.prom_admin_password.result
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

module "cert-manager" {
  source = "./create-cert-manager"

  count                    = var.tls_certificate_type != "none" ? 1 : 0
  tls_certificate_type     = var.tls_certificate_type
  monitoring_namespace     = var.monitoring_namespace
  cluster_issuer_email     = var.cluster_issuer_email
  cluster_issuer_name      = var.cluster_issuer_name
  tls_secret_name          = local.tls_secret_name
  api_dns_name             = var.api_dns_name
  certificate_cert_content = var.certificate_cert_content
  certificate_key_content  = var.certificate_key_content
  is_bare_metal            = var.is_bare_metal

  depends_on = [module.create-ingress-nginx]
}

module "loki" {
  source = "./create-loki"

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
  resources                            = var.resources
}

module "keycloak" {
  source = "./create-keycloak"

  count = var.create_keycloak ? 1 : 0

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
}

module "create_vault" {
  source = "./create_vault"

  count = var.vault_create ? 1 : 0

  namespace             = var.vault_namespace
  helm_repo_url         = var.vault_helm_repo_url
  helm_chart            = var.vault_helm_chart
  helm_chart_version    = var.vault_helm_chart_version
  helm_release_name     = var.vault_helm_release_name
  vault_replicas        = var.vault_replicas
  vault_secret_name     = var.vault_secret_name
  vault_ingress_enabled = var.vault_ingress_enabled
  vault_dns_name        = var.api_dns_name

  depends_on = [module.cert-manager]
}

module "create_argocd" {
  source = "./create_argocd"

  count = var.argocd_create ? 1 : 0

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

  depends_on = [ module.create_vault ]
}

module "create_vault_secrets_operator" {
  source = "./create-vault-secrets-operator"

  count = var.create_vault_secrets_operator ? 1 : 0

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
