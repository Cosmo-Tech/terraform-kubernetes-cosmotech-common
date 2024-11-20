locals {
  values_tekton = {
    "NAMESPACE"             = var.namespace
  }
  instance_name = var.helm_release_name
  dashboard_name = var.dashboard_helm_release_name
}

resource "kubernetes_namespace" "tekton_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "tekton-pipelines" {
  name         = local.instance_name
  repository   = var.helm_repo_url
  chart        = var.helm_chart
  version      = var.helm_chart_version
  namespace    = var.namespace
  reset_values = true
  timeout      = 600

  values = [
    templatefile("${path.module}/values.yaml", local.values_tekton)
  ]

  depends_on = [
    kubernetes_namespace.tekton_namespace
  ]
}

resource "helm_release" "tekton-dashboard" {
  name         = local.dashboard_name
  repository   = var.dashboard_helm_repo_url
  chart        = var.dashboard_helm_chart
  version      = var.dashboard_helm_chart_version
  namespace    = var.namespace
  reset_values = true
  timeout      = 600

  values = [
    templatefile("${path.module}/values-dashboard.yaml", local.values_tekton)
  ]

    depends_on = [
    kubernetes_namespace.tekton_namespace, helm_release.tekton-pipelines
  ]
}