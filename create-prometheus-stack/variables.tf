variable "redis_admin_password" {
  type = string
}

variable "prom_admin_password" {
  type = string
}

variable "monitoring_namespace" {
  type = string
}

variable "api_dns_name" {
  type = string
}

variable "tls_secret_name" {
  type = string
}

variable "redis_host_namespace" {
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

variable "redis_port" {
  type = number
}

variable "helm_chart" {
  type = string
}

variable "helm_repo_url" {
  type = string
}

variable "helm_release_name" {
  type = string
}

variable "prometheus_stack_version" {
  type = string
}

variable "prom_pv_existing_name" {
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
