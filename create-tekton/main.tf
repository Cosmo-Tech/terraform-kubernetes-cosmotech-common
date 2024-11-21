locals {
  values_tekton = {
    "NAMESPACE"             = var.namespace
  }
  instance_name = var.helm_release_name
  dashboard_name = var.dashboard_helm_release_name
  triggers_name = var.triggers_helm_release_name
  interceptors_name = var.interceptors_helm_release_name
}

resource "kubernetes_namespace" "tekton_namespace" {
  metadata {
    name = var.namespace
  }
}


resource "kubernetes_manifest" "tekton-pipelines" {
    yaml_body       = templatefile("${path.module}/tekton-pipelines.yaml")
    validate_schema = false
}
