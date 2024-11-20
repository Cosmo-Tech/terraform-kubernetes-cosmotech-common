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

variable "dashboard_helm_repo_url" {
  type    = string
}

variable "dashboard_helm_chart" {
  type    = string
}

variable "dashboard_helm_chart_version" {
  type    = string
}

variable "dashboard_helm_release_name" {
  type    = string
}