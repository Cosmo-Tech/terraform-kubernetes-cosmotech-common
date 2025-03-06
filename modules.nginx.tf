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