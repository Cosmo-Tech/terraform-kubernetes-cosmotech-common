variable "vault_secrets_operator_deploy" {
  type = bool
}

variable "vault_secrets_operator_namespace" {
  type = string
}

variable "vault_secrets_operator_helm_repo_url" {
  type = string
}

variable "vault_secrets_operator_helm_chart" {
  type = string
}

variable "vault_secrets_operator_helm_chart_version" {
  type = string
}

variable "vault_secrets_operator_helm_release_name" {
  type = string
}

variable "vault_secrets_operator_vault_address" {
  type = string
}

variable "vault_secrets_operator_allowed_namespaces" {
  type = list(string)
}

variable "vault_secrets_operator_replicas" {
  type = number
}

variable "vault_secrets_operator_organization" {
  type = string
}
