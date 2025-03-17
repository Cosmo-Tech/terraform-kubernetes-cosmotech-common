module "create_vault" {
  source = "./create_vault"

  count = var.vault_deploy ? 1 : 0

  namespace             = var.vault_namespace
  helm_repo_url         = var.vault_helm_repo_url
  helm_chart            = var.vault_helm_chart
  helm_chart_version    = var.vault_helm_chart_version
  helm_release_name     = var.vault_helm_release_name
  vault_replicas        = var.vault_replicas
  vault_secret_name     = var.vault_secret_name
  vault_ingress_enabled = var.vault_ingress_enabled
  vault_dns_name        = var.api_dns_name

  depends_on = [module.cert-manager]
}

module "create_vault_secrets_operator" {
  source = "./create-vault-secrets-operator"

  count = var.vault_secrets_operator_deploy ? 1 : 0

  namespace          = var.vault_secrets_operator_namespace
  helm_repo_url      = var.vault_secrets_operator_helm_repo_url
  helm_chart         = var.vault_secrets_operator_helm_chart
  helm_chart_version = var.vault_secrets_operator_helm_chart_version
  helm_release_name  = var.vault_secrets_operator_helm_release_name
  vault_address      = var.vault_secrets_operator_vault_address
  replicas           = var.vault_secrets_operator_replicas
  allowed_namespaces = var.vault_secrets_operator_allowed_namespaces
  tenant_id          = var.tenant_id
  vault_namespace    = var.vault_namespace
  organization       = var.vault_secrets_operator_organization

  depends_on = [module.create_vault]
}
