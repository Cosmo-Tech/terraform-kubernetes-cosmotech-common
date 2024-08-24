locals {
  values_vault_secrets_operator = {
    "NAMESPACE"          = var.namespace
    "REPLICAS"           = var.replicas
    "VAULT_ADDR"         = var.vault_address
  }
  instance_name = var.helm_release_name
}

resource "kubernetes_namespace" "vault_secrets_operator" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "vault_secrets_operator" {
  name       = local.instance_name
  repository = var.helm_repo_url
  chart      = var.helm_chart
  version    = var.helm_chart_version
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", local.values_vault_secrets_operator)
  ]

  set {
    name  = "vault.address"
    value = var.vault_address
  }

  depends_on = [
    kubernetes_namespace.vault_secrets_operator,
  ]
}
