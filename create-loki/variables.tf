variable "monitoring_namespace" {
  type    = string
}

variable "loki_release_name" {
  type    = string
}
variable "loki_persistence_memory" {
  type    = string
}

variable "loki_retention_period" {
  type    = string
}

variable "loki_helm_repo_url" {
  type    = string
}

variable "loki_helm_chart" {
  type    = string
}

variable "loki_max_entries_limet_per_query" {
  type    = number
}

variable "grafana_loki_compatibility_image_tag" {
  type = string
}

variable "is_bare_metal" {
  type = bool
}

variable "resources" {
}

variable "loki_helm_chart_version" {
  type = string
}

variable "pvc_loki_storage_class_name" {
  type = string
}

variable "pvc_grafana_storage_class_name" {
  type = string
}