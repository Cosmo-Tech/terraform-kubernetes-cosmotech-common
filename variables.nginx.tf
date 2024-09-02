variable "nginx_helm_repo_url" {
  type    = string
  default = "https://kubernetes.github.io/ingress-nginx"
}

variable "nginx_helm_release_name" {
  type    = string
  default = "ingress-nginx"
}

variable "ingress_nginx_version" {
  type    = string
  default = "4.2.5"
}

variable "nginx_namespace" {
  type    = string
  default = "ingress-nginx"
}

variable "monitoring_namespace" {
  type    = string
  default = "cosmotech-monitoring"
}

variable "publicip_address" {
  type = string
}

variable "tls_secret_name" {
  type = string
}

variable "publicip_resource_group" {
  type = string
}

variable "is_bare_metal" {
  type = bool
}
