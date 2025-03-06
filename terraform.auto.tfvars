# Azure
client_id     = ""
client_secret = ""

host                   = ""
client_certificate     = ""
client_key             = ""
cluster_ca_certificate = ""

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
keycloak_ingress_hostname   = ""
keycloak_namespace          = "keycloak"

# Loki
loki_release_name                    = "loki"
loki_persistence_memory              = "4Gi"
loki_retention_period                = "720h"
loki_helm_repo_url                   = "https://grafana.github.io/helm-charts"
loki_helm_chart                      = "loki-stack"
loki_helm_chart_version              = "2.10.2"
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

# Postgres for keycloak
postgres_helm_repo          = "https://charts.bitnami.com/bitnami"
postgres_helm_chart         = "postgresql"
postgres_helm_chart_version = "15.5.1"

pvc_keycloak_postgres_deploy             = false
pvc_keycloak_postgres_storage_accessmode = "ReadWriteOnce"
pvc_keycloak_postgres_storage_class_name = "default"
pvc_keycloak_postgres_storage_gbi        = "32Gi"
pvc_postgres_keycloak_existing_name      = "pvc-disk-postgres-core-keycloak"

# Monitoring
prometheus_stack_deploy       = true
monitoring_namespace          = "cosmotech-monitoring"
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
prom_redis_host_namespace     = ""
prom_pvc_existing_name = "pvc-disk-prometheus-core"

# ArgoCD
argocd_deploy                  = false
argocd_helm_chart              = "argo-cd"
argocd_helm_chart_version      = "7.5.0"
argocd_helm_release_name       = "argocd"
argocd_helm_repo_url           = "https://argoproj.github.io/argo-helm"
argocd_replicas                = 3
argocd_create_ingress          = false
argocd_namespace               = "argocd"
argocd_project                 = "phoenix"
argocd_setup_job_image_version = "v2.0.5"
argocd_repositories = [
  {
    url      = "https://github.com/Cosmo-Tech/cosmotech-api.git"
    private  = false
    username = ""
    token    = ""
  }
]

# vault
vault_deploy             = true
vault_helm_chart         = "vault"
vault_helm_chart_version = "0.28.1"
vault_helm_release_name  = "vault"
vault_helm_repo_url      = "https://helm.releases.hashicorp.com"
vault_namespace          = "vault"
vault_replicas           = 1
vault_secret_name        = "vault-token-secret"
vault_ingress_enabled    = true


# Vault auto unseal
auto_restart_deploy        = false
auto_restart_start_hours   = 5
auto_restart_start_minutes = 0

# Vault secrets operator
vault_secrets_operator_deploy             = false
vault_secrets_operator_helm_chart         = "vault-secrets-operator"
vault_secrets_operator_helm_chart_version = "0.8.1"
vault_secrets_operator_helm_release_name  = "vault-secrets-operator"
vault_secrets_operator_helm_repo_url      = "https://helm.releases.hashicorp.com"
vault_secrets_operator_namespace          = "vault-secrets-operator"
vault_secrets_operator_vault_address      = "http://vault.vault.svc.cluster.local:8200"
vault_secrets_operator_replicas           = 1


# velero
velero_deploy                        = false
velero_init_container_image          = "velero/velero-plugin-for-microsoft-azure:v1.11.0"
velero_blob_storage_name             = "backups"
velero_cloud_provider                = "azure"
velero_bucket_name                   = "velero"
velero_release_name                  = "velero"
velero_helm_repo_url                 = "https://vmware-tanzu.github.io/helm-charts"
velero_helm_chart                    = "velero"
velero_helm_chart_version            = "8.0.0"
velero_namespace                     = "velero"
velero_storage_account_name          = ""
velero_storage_account_resource_name = ""
velero_azure_subcription_id          = ""
velero_azure_tenant_id               = ""

# remote 
tf_resource_group_name  = ""
tf_storage_account_name = ""
tf_access_key           = ""
tf_container_name       = ""
tf_blob_name            = ""
tf_blob_name_core_ip    = ""
tf_blob_name_core_infra = ""

# remote dns
tf_resource_group_name_dns  = ""
tf_storage_account_name_dns = ""
tf_container_name_dns       = ""
tf_blob_name_core_dns       = ""
tf_access_key_dns           = ""

# admin user or not
kubernetes_cluster_admin_activate = false

# storage class
storageclass_azure_deploy      = false
storageclass_provisioner_azure = "disk.csi.azure.com"
storageclass_bare_deploy       = false
storageclass_provisioner_bare  = "longhorn"

nginx_deploy    = true
loki_deploy     = true
keycloak_deploy = false
is_bare_metal   = false

# tekton 
tekton_deploy                          = false
tekton_namespace                       = "tekton-pipelines"
tekton_helm_repo_url                   = "https://cosmo-tech.github.io/tekton/"
tekton_helm_chart                      = "tekton-pipelines"
tekton_helm_chart_version              = "0.1.21"
tekton_helm_release_name               = "tekton-pipelines"
tekton_dashboard_helm_repo_url         = "https://cosmo-tech.github.io/tekton/"
tekton_dashboard_helm_chart            = "tekton-dashboard"
tekton_dashboard_helm_chart_version    = "0.1.21"
tekton_dashboard_helm_release_name     = "tekton-dashboard"
tekton_triggers_helm_repo_url          = "https://cosmo-tech.github.io/tekton/"
tekton_triggers_helm_chart             = "tekton-triggers"
tekton_triggers_helm_chart_version     = "0.1.21"
tekton_triggers_helm_release_name      = "tekton-triggers"
tekton_interceptors_helm_repo_url      = "https://cosmo-tech.github.io/tekton/"
tekton_interceptors_helm_chart         = "tekton-interceptors"
tekton_interceptors_helm_chart_version = "0.1.21"
tekton_interceptors_helm_release_name  = "tekton-interceptors"
