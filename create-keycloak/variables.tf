variable "keycloak_admin_user" {
  type = string
  default = "admin-cosmo"
}

variable "keycloak_postgres_user" {
  type = string
  default = "keycloak_postgres_user"
}

variable "keycloak_ingress_hostname" {
  type = string
}

variable "is_bare_metal" {
  type = bool
}

variable "keycloak_helm_repo" {
  type = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "keycloak_helm_chart" {
  type = string
  default = "keycloak"
}

variable "keycloak_helm_chart_version" {
  type = string
  default = "15.5.1"
}

variable "postgres_helm_repo" {
  type = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "postgres_helm_chart" {
  type = string
  default = "postgresql"
}

variable "postgres_helm_chart_version" {
  type = string
  default = "21.3.1"
}
