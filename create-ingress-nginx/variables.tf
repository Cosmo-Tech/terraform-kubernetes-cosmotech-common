variable "helm_repo_url" {
  type    = string
}

variable "helm_release_name" {
  type    = string
}

variable "ingress_nginx_version" {
  type    = string
}

variable "namespace" {
  type    = string
}

variable "monitoring_namespace" {
  type    = string
}

variable "loadbalancer_ip" {
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
