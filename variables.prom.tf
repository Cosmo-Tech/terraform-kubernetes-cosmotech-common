variable "prometheus_stack_deploy" {
  type = bool
}

variable "prom_redis_host_namespace" {
  type = string
}

variable "prom_storage_resource_request" {
  type = string
}

variable "prom_storage_class_name" {
  type = string
}

variable "prom_replicas_number" {
  type = string
}

variable "prom_retention" {
  type = string
}

variable "prom_redis_port" {
  type = number
}

variable "prom_helm_chart" {
  type = string
}

variable "prom_helm_repo_url" {
  type = string
}

variable "prom_helm_release_name" {
  type = string
}

variable "prom_stack_version" {
  type = string
}

variable "redis_admin_password" {
  type = string
}

variable "prom_admin_password" {
  type = string
}

variable "prom_pvc_existing_name" {
  type = string
}

variable "prom_resources" {
  type = object({
    requests = object({
      cpu    = string
      memory = string
    })
    limits = object({
      cpu    = string
      memory = string
    })
  })
}

variable "prom_alert_manager_resources" {
  type = object({
    requests = object({
      cpu    = string
      memory = string
    })
    limits = object({
      cpu    = string
      memory = string
    })
  })
}
