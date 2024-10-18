variable "cert_helm_repo_url" {
  type = string
}

variable "cert_helm_release_name" {
  type = string
}

variable "cert_manager_version" {
  type        = string
  description = "HELM Chart Version for cert-manager"
}

variable "cluster_issuer_server" {
  description = "The ACME server URL"
  type        = string
}

variable "cluster_issuer_email" {
  type = string
}

variable "cluster_issuer_name" {
  type = string
}

variable "cert_namespace" {
  type = string
}

variable "tls_secret_name" {
  type = string
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

variable "publicip_resource_group" {
  type = string
}

variable "publicip_address" {
  type = string
}
