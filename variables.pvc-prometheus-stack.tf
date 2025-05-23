variable "pvc_grafana_storage_gbi" {
  type = string
}

variable "pvc_grafana_storage_class_name" {
  type = string
}

variable "pvc_grafana_storage_accessmode" {
  type = string
}

variable "pvc_prometheus_stack_deploy" {
  type = bool
}