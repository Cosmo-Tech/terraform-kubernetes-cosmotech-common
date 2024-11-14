terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
  }
}

data "kubectl_path_documents" "manifests-tekton-yaml" {
  pattern = "${path.module}/manifests/*.yaml"
}

resource "kubectl_manifest" "tekton-pipelines" {
  for_each  = data.kubectl_path_documents.manifests-tekton-yaml.manifests
  yaml_body = each.value
  wait_for_rollout = false
  force_new = true
}

data "kubectl_path_documents" "manifests-tekton-dashboard-yaml" {
  pattern = "${path.module}/manifests-tekton-dashboard/*.yaml"
}

resource "kubectl_manifest" "tekton-dashboard" {
  for_each  = data.kubectl_path_documents.manifests-tekton-dashboard-yaml.manifests
  yaml_body = each.value
  wait_for_rollout = false
  force_new = true
  depends_on = [kubectl_manifest.tekton-pipelines]
}