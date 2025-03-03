variable "pvc_keycloak_postgres_storage_gbi" {
  type = string
}
variable "pvc_keycloak_postgres_storage_class_name" {
  type = string
}
variable "pvc_keycloak_postgres_deploy" {
  type = bool
}
variable "pvc_keycloak_postgres_storage_accessmode" {
  type = string
}
variable "pvc_postgres_keycloak_existing_name" {
  type = string
}