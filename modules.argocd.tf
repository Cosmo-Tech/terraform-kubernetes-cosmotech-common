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
  argocd_repository_access_token = var.argocd_repository_access_token
  argocd_repository_username     = var.argocd_repository_username

  depends_on = [module.create_vault]
}
