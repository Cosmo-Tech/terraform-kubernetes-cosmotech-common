terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
  }
}

data "http" "argo_crds" {
  for_each = toset(var.argo_workflows_crds_list)
  url      = "https://raw.githubusercontent.com/argoproj/argo-workflows/${var.argo_workflows_app_version}/manifests/base/crds/minimal/${each.key}"
}

data "kubectl_file_documents" "argo_crds" {
  for_each = data.http.argo_crds
  content  = each.value.response_body
}

resource "kubectl_manifest" "argo_crds" {
  for_each  = data.kubectl_file_documents.argo_crds
  yaml_body = data.kubectl_file_documents.argo_crds[each.key].documents[0]
}