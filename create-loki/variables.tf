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

variable "helm_chart" {
  type    = string
  default = "loki-stack"
}

variable "loki_max_entries_limet_per_query" {
  type    = number
  default = 50000
}

variable "grafana_loki_compatibility_image_tag" {
  type = string
}

variable "is_bare_metal" {
  type = bool
}

variable "resources" {
}

variable "provisioner" {
  type = string
}