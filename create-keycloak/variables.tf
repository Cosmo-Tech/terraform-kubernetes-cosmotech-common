variable "keycloak_admin_user" {
  type    = string
}

variable "keycloak_postgres_user" {
  type    = string
}

variable "keycloak_ingress_hostname" {
  type = string
}

variable "is_bare_metal" {
  type = bool
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

variable "postgres_helm_repo" {
  type    = string
}

variable "postgres_helm_chart" {
  type    = string
}

variable "postgres_helm_chart_version" {
  type    = string
}

variable "provisioner" {
  type = string
}

variable "keycloak_namespace" {
  type = string
}

variable "pvc_postgres_keycloak_existing_name" {
  type = string
}