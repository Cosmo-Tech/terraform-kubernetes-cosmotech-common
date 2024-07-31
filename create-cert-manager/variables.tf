variable "helm_repo_url" {
  type    = string
}

variable "helm_release_name" {
  type    = string
}

variable "cert_manager_version" {
  type        = string
}

variable "cluster_issuer_server" {
  type        = string
}

variable "cluster_issuer_email" {
  type = string
}

variable "cluster_issuer_name" {
  type    = string
}

variable "namespace" {
  type    = string
}

variable "monitoring_namespace" {
  type    = string
}

variable "tls_secret_name" {
  type    = string
}

variable "api_dns_name" {
  type = string
}

variable "tls_certificate_type" {
  type = string
}

variable "certificate_cert_content" {
  type = string
}

variable "certificate_key_content" {
  type = string
}

variable "is_bare_metal" {
  type = bool
}