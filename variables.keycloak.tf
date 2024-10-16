variable "keycloak_deploy" {
  type = bool
}

variable "keycloak_admin_user" {
  type    = string
}

variable "keycloak_postgres_user" {
  type    = string
}

variable "keycloak_ingress_hostname" {
  type = string
}

variable "keycloak_helm_repo" {
  type    = string
}

variable "keycloak_helm_chart" {
  type    = string
}

variable "keycloak_helm_chart_version" {
  type    = string
}

variable "keycloack_provisioner" {
  type    = string
}
