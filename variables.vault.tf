variable "vault_deploy" {
  type = bool
}

variable "vault_namespace" {
  type    = string
  default = "vault"
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

variable "auto_restart_start_minutes" {
  type = number
  validation {
    condition     = var.auto_restart_start_minutes >= 0 && var.auto_restart_start_minutes < 60
    error_message = "Minutes must be between 0 and 59"
  }
  default = 0
}

variable "auto_restart_start_hours" {
  type = number
  validation {
    condition     = var.auto_restart_start_hours >= 0 && var.auto_restart_start_hours < 24
    error_message = "Hours must be between 0 and 23"
  }
  default = 5
}