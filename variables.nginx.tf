variable "ingress_nginx_version" {
  type    = string
  default = "4.2.5"
}

variable "cluster_issuer_email" {
  type = string
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

variable "api_dns_name" {
  type = string
}

variable "publicip_address" {
  type = string
}

variable "certificate_cert_content" {
  type = string
}

variable "certificate_key_content" {
  type = string
}

