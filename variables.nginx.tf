variable "nginx_helm_repo_url" {
  type    = string
  default = "https://kubernetes.github.io/ingress-nginx"
}

variable "nginx_helm_release_name" {
  type    = string
  default = "ingress-nginx"
}

variable "nginx_ingress_version" {
  type    = string
  default = "4.10.1"
}

variable "nginx_namespace" {
  type    = string
  default = "ingress-nginx"
}

variable "nginx_deploy" {
  type = bool
}