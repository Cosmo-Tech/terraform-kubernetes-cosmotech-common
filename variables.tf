# Azure only environment variables
variable "client_id" {
  type        = string
  description = "The client id of the app registration used to build this"
  default     = ""
}

variable "client_secret" {
  type        = string
  description = "The client secret of the app registration used to build this"
  default     = ""
}

variable "subscription_id" {
  type        = string
  description = "The subscription id"
}

variable "tenant_id" {
  type        = string
  description = "The tenant id"
}

variable "publicip_resource_group" {
  type = string
}

# Common environment variables
variable "cluster_issuer_email" {
  type    = string
  default = "platform@cosmotech.com"
}

variable "cluster_issuer_name" {
  type    = string
  default = "letsencrypt-prod"
}

variable "tls_secret_name" {
  type    = string
  default = "letsencrypt-prod"
}

variable "tls_certificate_type" {
  type    = string
  default = "let_s_encrypt"
  validation {
    condition = contains([
      "let_s_encrypt",
      "custom",
      "none"
    ], var.tls_certificate_type)
    error_message = "Only let_s_encrypt and none are supported for tls_certificate_type."
  }
}

variable "namespace" {
  type    = string
  default = ""
}

variable "monitoring_namespace" {
  type    = string
  default = "cosmotech-monitoring"
}

variable "ingress_nginx_version" {
  type    = string
  default = "4.2.5"
}

variable "create_prometheus_stack" {
  type    = bool
  default = true
}

variable "api_dns_name" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "loadbalancer_ip" {
  type = string
}

variable "kube_config" {
}

variable "certificate_cert_content" {
}

variable "certificate_key_content" {
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

variable "prom_cpu_mem_limits" {
  type = string
}

variable "prom_cpu_mem_request" {
  type = string
}


variable "grafana_loki_compatibility_image_tag" {
  type = string
}