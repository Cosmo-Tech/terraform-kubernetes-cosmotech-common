variable "namespace" {
  type = string
}

variable "vault_namespace" {
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

variable "vault_address" {
  type = string
}

variable "replicas" {
  type = number
}