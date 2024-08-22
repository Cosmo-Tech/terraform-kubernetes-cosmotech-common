module "create-ingress-nginx" {
  source = "./create-ingress-nginx"

  is_bare_metal           = var.is_bare_metal
  monitoring_namespace    = var.monitoring_namespace
  ingress_nginx_version   = var.ingress_nginx_version
  loadbalancer_ip         = var.loadbalancer_ip
  tls_secret_name         = local.tls_secret_name
  publicip_resource_group = var.publicip_resource_group

  depends_on = [
    module.create-prometheus-stack
  ]
}

module "create-prometheus-stack" {
  source = "./create-prometheus-stack"

  count                = var.create_prometheus_stack ? 1 : 0
  namespace            = var.namespace
  monitoring_namespace = var.monitoring_namespace
  api_dns_name         = var.api_dns_name
  tls_secret_name      = local.tls_secret_name
  redis_admin_password = random_password.redis_admin_password.result
  prom_admin_password  = random_password.prom_admin_password.result
  prom_cpu_mem_limits  = var.prom_cpu_mem_limits
  prom_cpu_mem_request = var.prom_cpu_mem_request
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

  namespace                            = var.namespace
  monitoring_namespace                 = var.monitoring_namespace
  loki_release_name                    = var.loki_release_name
  loki_persistence_memory              = var.loki_persistence_memory
  loki_retention_period                = var.loki_retention_period
  helm_repo_url                        = var.helm_repo_url
  helm_chart                           = var.helm_chart
  loki_max_entries_limet_per_query     = var.loki_max_entries_limet_per_query
  grafana_loki_compatibility_image_tag = var.grafana_loki_compatibility_image_tag
  is_bare_metal                        = var.is_bare_metal
  provisioner                          = var.provisioner
  resources                            = var.resources
}

module "keycloak" {
  source = "./create-keycloak"

  count                     = var.create_keycloak ? 1 : 0
  keycloak_ingress_hostname = var.api_dns_name
  is_bare_metal             = var.is_bare_metal
  provisioner               = var.provisioner
}

module "create_argocd" {
  source = "./create_argocd"

  count = var.create_argocd ? 1 : 0

  namespace                      = var.argocd_namespace
  helm_repo_url                  = var.argocd_helm_repo_url
  helm_chart                     = var.argocd_helm_chart
  helm_chart_version             = var.argocd_helm_chart_version
  helm_release_name              = var.argocd_helm_release_name
  replicas                       = var.argocd_replicas
  create_ingress                 = var.argocd_create_ingress
  argocd_project                 = var.argocd_project
  argocd_repositories            = var.argocd_repositories
  argocd_repository_username     = var.argocd_repository_username
  argocd_repository_access_token = var.argocd_repository_access_token
  argocd_dns_name                = var.api_dns_name
  argocd_setup_job_image_version = var.argocd_setup_job_image_version

  depends_on = [module.cert-manager]
}

module "create_vault" {
  source = "./create_vault"

  count = var.create_vault ? 1 : 0

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

module "create_vault_secrets_operator" {
  source = "./create-vault-secrets-operator"

  count = var.create_vault_secrets_operator ? 1 : 0

  namespace          = var.vault_secrets_operator_namespace
  helm_repo_url      = var.vault_secrets_operator_helm_repo_url
  helm_chart         = var.vault_secrets_operator_helm_chart
  helm_chart_version = var.vault_secrets_operator_helm_chart_version
  helm_release_name  = var.vault_secrets_operator_helm_release_name
  vault_address      = var.vault_secrets_operator_vault_address
  allowed_namespaces = var.vault_secrets_operator_allowed_namespaces
  replicas           = var.vault_secrets_operator_replicas
  vault_namespace    = var.vault_namespace
  tenant_id          = var.tenant_id
  cluster_name       = var.cluster_name
  organization       = var.customer_name

  depends_on = [module.create_vault]
}
