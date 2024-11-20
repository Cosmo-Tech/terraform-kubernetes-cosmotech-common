# Azure
client_id     = ""
client_secret = ""

# Project
project_customer_name = "cosmotech"

# Cert-manager
cert_helm_repo_url       = "https://charts.jetstack.io"
cert_helm_release_name   = "cert-manager"
cert_manager_version     = "1.11.0"
cluster_issuer_server    = "https://acme-v02.api.letsencrypt.org/directory"
cluster_issuer_email     = "platform@cosmotech.com"
cluster_issuer_name      = "letsencrypt-prod"
cert_namespace           = "cert-manager"
tls_secret_name          = "letsencrypt-prod"
tls_certificate_type     = "let_s_encrypt"
certificate_cert_content = ""
certificate_key_content  = ""

# Keycloack
keycloak_admin_user         = "admin-cosmo"
keycloak_postgres_user      = "keycloak_postgres_user"
keycloak_helm_repo          = "https://charts.bitnami.com/bitnami"
keycloak_helm_chart         = "keycloak"
keycloak_helm_chart_version = "21.3.1"
keycloack_provisioner       = ""

# Loki
loki_release_name                    = "loki"
loki_persistence_memory              = "4Gi"
loki_retention_period                = "720h"
loki_helm_repo_url                   = "https://grafana.github.io/helm-charts"
loki_helm_chart                      = "loki-stack"
loki_max_entries_limet_per_query     = 50000
grafana_loki_compatibility_image_tag = ""
loki_provisioner                     = ""
loki_resources = [{

  name    = "loki"
  storage = "8Gi"
  labels = {
    "cosmotech.com/db" = "loki"
  }
  access_modes = ["ReadWriteOnce"]
  path         = "/mnt/loki-storage"
  }
  ,
  {
    name    = "grafana"
    storage = "8Gi"
    labels = {
      "cosmotech.com/db" = "grafana"
    }
    access_modes = ["ReadWriteOnce"]
    path         = "/mnt/grafana-storage"
}]

# Nginx
nginx_helm_repo_url     = "https://kubernetes.github.io/ingress-nginx"
nginx_helm_release_name = "ingress-nginx"
nginx_ingress_version   = "4.10.1"
nginx_namespace         = "ingress-nginx"

# Postgres
postgres_helm_repo          = "https://charts.bitnami.com/bitnami"
postgres_helm_chart         = "postgresql"
postgres_helm_chart_version = "15.5.1"

# Monitoring
monitoring_namespace          = "cosmotech-monitoring"
prometheus_stack_deploy       = true
prom_storage_resource_request = "64Gi"
prom_storage_class_name       = "default"
prom_replicas_number          = 1
prom_retention                = "100d"
prom_redis_port               = 6379
prom_helm_chart               = "kube-prometheus-stack"
prom_helm_repo_url            = "https://prometheus-community.github.io/helm-charts"
prom_helm_release_name        = "kube-prometheus-stack"
prom_stack_version            = "57.1.0"
prom_cpu_mem_limits           = ""
prom_cpu_mem_request          = ""
redis_admin_password          = ""
prom_admin_password           = ""

# ArgoCD
argocd_namespace = "argocd"

# Vault
vault_namespace = "vault"

# Vault auto unseal
auto_restart_start_hours   = 5
auto_restart_start_minutes = 0

# Vault secrets operator
vault_secrets_operator_namespace     = "vault-secrets-operator"
vault_secrets_operator_vault_address = "http://vault.vault.svc.cluster.local:8200"
vault_namespace                      = "vault"
tekton_namespace                     = "tekton-pipelines"
tekton_helm_repo_url                 = "https://lukacsbarni.github.io/tekton/"
tekton_helm_chart                    = "tekton-pipelines"
tekton_helm_chart_version            = "0.1.2"
tekton_helm_release_name             = "tekton-pipelines"

