variable "is_bare_metal" {
  type = bool
}

variable "monitoring_namespace" {
  type    = string
  default = "cosmotech-monitoring"
}

variable "cluster_name" {
  type = string
}