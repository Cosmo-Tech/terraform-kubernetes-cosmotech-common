variable "keycloak_deploy" {
  type = bool
}

variable "keycloak_admin_user" {
  type    = string
  default = "admin-cosmo"
}

variable "keycloak_postgres_user" {
  type    = string
  default = "keycloak_postgres_user"
}

variable "keycloak_ingress_hostname" {
  type = string
}

variable "keycloak_helm_repo" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "keycloak_helm_chart" {
  type    = string
  default = "keycloak"
}

variable "keycloak_helm_chart_version" {
  type    = string
  default = "21.3.1"
}

variable "keycloack_provisioner" {
  type    = string
  default = ""
}
