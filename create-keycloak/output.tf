output "out_keycloak_user" {
  value     = var.keycloak_admin_user
  sensitive = true
}

output "out_keycloak_password" {
  value     = random_password.keycloak_admin_password.result
  sensitive = true
}

output "out_postgres_user" {
  value     = var.keycloak_postgres_user
  sensitive = true
}

output "out_postgres_password" {
  value     = random_password.keycloak_postgresql_password.result
  sensitive = true
}

output "out_postgres_admin_password" {
  value     = random_password.keycloak_postgresql_admin_password.result
  sensitive = true
}
