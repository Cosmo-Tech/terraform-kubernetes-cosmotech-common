module "create-ingress-nginx" {
  source = "./create-ingress-nginx"

  is_bare_metal           = var.is_bare_metal
  monitoring_namespace    = var.monitoring_namespace
  ingress_nginx_version   = var.ingress_nginx_version
  loadbalancer_ip         = var.loadbalancer_ip
  tls_secret_name         = local.tls_secret_name
  publicip_resource_group = var.publicip_resource_group
  helm_repo_url           = var.ingress_nginx_helm_repo_url
  helm_release_name       = var.ingress_nginx_helm_release_name
  namespace               = var.ingress_nginx_namespace

  depends_on = [
    module.create-prometheus-stack
  ]
}

module "create-prometheus-stack" {
  source = "./create-prometheus-stack"

  count                         = var.create_prometheus_stack ? 1 : 0
  namespace                     = var.prom_namespace
  monitoring_namespace          = var.monitoring_namespace
  api_dns_name                  = var.api_dns_name
  tls_secret_name               = local.tls_secret_name
  redis_admin_password          = random_password.redis_admin_password.result
  prom_admin_password           = random_password.prom_admin_password.result
  prom_cpu_mem_limits           = var.prom_cpu_mem_limits
  prom_cpu_mem_request          = var.prom_cpu_mem_request
  prometheus_stack_version      = var.prometheus_stack_version
  helm_chart                    = var.prom_helm_chart
  helm_release_name             = var.prom_helm_release_name
  helm_repo_url                 = var.prom_helm_repo_url
  prom_storage_resource_request = var.prom_storage_resource_request
  prom_storage_class_name       = var.prom_storage_class_name
  prom_replicas_number          = var.prom_replicas_number
  prom_retention                = var.prom_retention
  redis_port                    = var.redis_port
}

module "cert-manager" {
  source = "./create-cert-manager"

  count                    = var.tls_certificate_type != "none" ? 1 : 0
  tls_certificate_type     = var.tls_certificate_type
  monitoring_namespace     = var.monitoring_namespace
  cluster_issuer_server    = var.cluster_issuer_server
  cluster_issuer_email     = var.cluster_issuer_email
  cluster_issuer_name      = var.cluster_issuer_name
  tls_secret_name          = local.tls_secret_name
  api_dns_name             = var.api_dns_name
  certificate_cert_content = var.certificate_cert_content
  certificate_key_content  = var.certificate_key_content
  is_bare_metal            = var.is_bare_metal
  namespace                = var.cert_manager_namespace
  helm_repo_url            = var.cert_manager_helm_repo_url
  helm_release_name        = var.cert_manager_helm_release_name
  cert_manager_version     = var.cert_manager_version

  depends_on = [module.create-ingress-nginx]
}

module "loki" {
  source = "./create-loki"

  namespace                            = var.loki_namespace
  monitoring_namespace                 = var.monitoring_namespace
  loki_release_name                    = var.loki_release_name
  loki_persistence_memory              = var.loki_persistence_memory
  loki_retention_period                = var.loki_retention_period
  helm_repo_url                        = var.loki_helm_repo_url
  helm_chart                           = var.loki_helm_chart
  loki_max_entries_limet_per_query     = var.loki_max_entries_limet_per_query
  grafana_loki_compatibility_image_tag = var.grafana_loki_compatibility_image_tag
  is_bare_metal                        = var.is_bare_metal
  provisioner                          = var.provisioner
  resources                            = var.resources
}

module "keycloak" {
  source = "./create-keycloak"

  count                       = var.create_keycloak ? 1 : 0
  keycloak_ingress_hostname   = var.api_dns_name
  is_bare_metal               = var.is_bare_metal
  provisioner                 = var.provisioner
  keycloak_admin_user         = var.keycloak_admin_user
  keycloak_postgres_user      = var.keycloak_postgres_user
  keycloak_helm_repo          = var.keycloak_helm_repo
  keycloak_helm_chart         = var.keycloak_helm_chart
  keycloak_helm_chart_version = var.keycloak_helm_chart_version
  postgres_helm_repo          = var.postgres_helm_repo
  postgres_helm_chart         = var.postgres_helm_chart
  postgres_helm_chart_version = var.postgres_helm_chart_version
}
