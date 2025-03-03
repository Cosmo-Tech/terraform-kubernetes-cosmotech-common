variable "keycloak_namespace" {
  type = string
}

variable "pvc_keycloak_postgres_storage_gbi" {
  type = string
}

variable "pvc_keycloak_postgres_storage_class_name" {
  type = string
}

variable "pvc_keycloak_postgres_storage_accessmode" {
  type = string
}
