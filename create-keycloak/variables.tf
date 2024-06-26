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
