variable "vault_deploy" {
  type = bool
}

variable "vault_namespace" {
  type = string
}

variable "vault_helm_repo_url" {
  type = string
}

variable "vault_helm_chart" {
  type = string
}

variable "vault_helm_chart_version" {
  type = string
}

variable "vault_helm_release_name" {
  type = string
}

variable "vault_replicas" {
  type = number
}

variable "vault_secret_name" {
  type = string
}

variable "vault_ingress_enabled" {
  type = bool
}

variable "auto_restart_deploy" {
  type = bool
}

variable "auto_start_aks_minutes" {
  type = number
}

variable "auto_start_aks_hours" {
  type = number
}