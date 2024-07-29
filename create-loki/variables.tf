variable "monitoring_namespace" {
  type    = string
  default = "cosmotech-monitoring"
}

variable "namespace" {
  type    = string
  default = "phoenix"
}

variable "loki_release_name" {
  type    = string
  default = "loki"
}
variable "loki_persistence_memory" {
  type    = string
  default = "4Gi"
}

variable "loki_retention_period" {
  type    = string
  default = "720h"
}

variable "helm_repo_url" {
  type    = string
  default = "https://grafana.github.io/helm-charts"
}

variable "loki_helm_chart" {
  type    = string
  default = "loki"
}

variable "loki_max_entries_limet_per_query" {
  type    = number
  default = 50000
}

variable "grafana_loki_compatibility_image_tag" {
  type = string
}

variable "promtail_release_name" {
  type    = string
  default = "promtail"
}

variable "promtail_helm_chart" {
  type    = string
  default = "promtail"
}

variable "promtail_chart_version" {
  type    = string
  default = "6.16.4"
}

variable "loki_chart_version" {
  type    = string
  default = "6.7.1"
}