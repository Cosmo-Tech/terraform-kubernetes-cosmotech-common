variable "ingress_nginx_helm_repo_url" {
  type    = string
  default = "https://kubernetes.github.io/ingress-nginx"
}

variable "ingress_nginx_helm_release_name" {
  type    = string
  default = "ingress-nginx"
}

variable "ingress_nginx_namespace" {
  type    = string
  default = "ingress-nginx"
}

variable "ingress_nginx_version" {
  type    = string
  default = "4.2.5"
}

variable "publicip_resource_group" {
  type = string
}

variable "loadbalancer_ip" {
  type = string
}