variable "tekton_namespace" {
  type = string
}

variable "tekton_helm_repo_url" {
  type = string
}

variable "tekton_helm_chart" {
  type = string
}

variable "tekton_helm_chart_version" {
  type = string
}

variable "tekton_helm_release_name" {
  type = string
}

variable "tekton_deploy" {
  type = bool
}