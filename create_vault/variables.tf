variable "namespace" {
  type = string
}

variable "helm_repo_url" {
  type    = string
}

variable "helm_chart" {
  type    = string
}

variable "helm_chart_version" {
  type    = string
}

variable "helm_release_name" {
  type    = string
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

variable "vault_dns_name" {
  type = string
}

variable "auto_restart_deploy" {
  type = bool
}

variable "start_aks_minutes" {
  type = number
  validation {
    condition = can(regex(var.start_aks_minutes, range(0,60)))
    error_message = "Minutes must be between 0 and 59"
  }
}

variable "start_aks_hours" {
  type = number
  validation {
    condition = can(regex(var.start_aks_minutes, range(0,24)))
    error_message = "Hours must be between 0 and 23"
  }
}