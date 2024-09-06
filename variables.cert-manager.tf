variable "cert_deploy" {
  type = bool
}

variable "cert_helm_repo_url" {
  type    = string
  default = "https://charts.jetstack.io"
}

variable "cert_helm_release_name" {
  type    = string
  default = "cert-manager"
}

variable "cert_manager_version" {
  type        = string
  description = "HELM Chart Version for cert-manager"
  default     = "1.11.0"
}

variable "cluster_issuer_server" {
  description = "The ACME server URL"
  type        = string
  default     = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "cluster_issuer_email" {
  type = string
}

variable "cluster_issuer_name" {
  type    = string
  default = "letsencrypt-prod"
}

variable "cert_namespace" {
  type    = string
  default = "cert-manager"
}

variable "tls_secret_name" {
  type    = string
  default = "letsencrypt-prod"
}

variable "api_dns_name" {
  type = string
}

variable "tls_certificate_type" {
  type    = string
  default = "let_s_encrypt"
}

variable "certificate_cert_content" {
  type    = string
  default = ""
}

variable "certificate_key_content" {
  type    = string
  default = ""
}