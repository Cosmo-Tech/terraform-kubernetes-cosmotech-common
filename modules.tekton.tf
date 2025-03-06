
module "create_tekton" {
  source = "./create-tekton"

  count = var.tekton_deploy ? 1 : 0

  namespace                       = var.tekton_namespace
  helm_repo_url                   = var.tekton_helm_repo_url
  helm_chart                      = var.tekton_helm_chart
  helm_chart_version              = var.tekton_helm_chart_version
  helm_release_name               = var.tekton_helm_release_name
  dashboard_helm_repo_url         = var.tekton_dashboard_helm_repo_url
  dashboard_helm_chart            = var.tekton_dashboard_helm_chart
  dashboard_helm_chart_version    = var.tekton_dashboard_helm_chart_version
  dashboard_helm_release_name     = var.tekton_dashboard_helm_release_name
  triggers_helm_repo_url          = var.tekton_triggers_helm_repo_url
  triggers_helm_chart             = var.tekton_triggers_helm_chart
  triggers_helm_chart_version     = var.tekton_triggers_helm_chart_version
  triggers_helm_release_name      = var.tekton_triggers_helm_release_name
  interceptors_helm_repo_url      = var.tekton_interceptors_helm_repo_url
  interceptors_helm_chart         = var.tekton_interceptors_helm_chart
  interceptors_helm_chart_version = var.tekton_interceptors_helm_chart_version
  interceptors_helm_release_name  = var.tekton_interceptors_helm_release_name

}