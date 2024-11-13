terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
  }
}


resource "kubernetes_manifest" "tekton-pipelines" {
    yaml_body       = templatefile("${path.module}/tekton-pipelines.yaml")
    validate_schema = false
}
