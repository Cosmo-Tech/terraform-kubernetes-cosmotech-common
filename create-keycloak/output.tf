output "out_keycloak_user" {
  value     = var.keycloak_admin_user
  sensitive = true
}

output "out_postgres_user" {
  value     = var.keycloak_postgres_user
  sensitive = true
}
