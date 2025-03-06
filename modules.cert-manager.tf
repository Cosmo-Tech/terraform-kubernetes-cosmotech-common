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