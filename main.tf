locals {
  tls_secret_name = var.tls_certificate_type != "none" ? var.tls_secret_name : ""
}

resource "random_password" "prom_admin_password" {
  length  = 30
  special = false
}

resource "random_password" "redis_admin_password" {
  length  = 30
  special = false
}