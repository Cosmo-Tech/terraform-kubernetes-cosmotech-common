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