locals {
  tls_secret_name        = var.tls_certificate_type != "none" ? var.tls_secret_name : ""
}

provider "kubernetes" {
  config_path = var.config_path
}

provider "helm" {
  kubernetes {
    config_path = var.config_path
  }
}

provider "kubectl" {
  config_path = var.config_path

  load_config_file = true
}

resource "random_password" "prom_admin_password" {
  length  = 30
  special = false
}

resource "random_password" "redis_admin_password" {
  length  = 30
  special = false
}