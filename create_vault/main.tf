locals {
  values_vault = {
    "REPLICAS"              = var.vault_replicas
    "NAMESPACE"             = var.namespace
    "VAULT_INGRESS_ENABLED" = var.vault_ingress_enabled
    "VAULT_DNS_NAME"        = var.vault_dns_name
  }
  instance_name = var.helm_release_name
}

resource "kubernetes_namespace" "vault_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "vault" {
  name         = local.instance_name
  repository   = var.helm_repo_url
  chart        = var.helm_chart
  version      = var.helm_chart_version
  namespace    = var.namespace
  reset_values = true
  timeout      = 600

  values = [
    templatefile("${path.module}/values.yaml", local.values_vault)
  ]

  depends_on = [
    kubernetes_namespace.vault_namespace
  ]
}

resource "kubectl_manifest" "vault_unseal_role" {
  validate_schema = false
  yaml_body = templatefile("${path.module}/templates/vault-unseal-role.yaml.tpl",
    local.values_vault
  )
}

resource "kubectl_manifest" "vault_unseal_rolebinding" {
  validate_schema = false
  yaml_body = templatefile("${path.module}/templates/vault-unseal-rolebinding.yaml.tpl",
    local.values_vault
  )
}

# Configmap
resource "kubernetes_config_map" "vault_unseal_script" {
  metadata {
    name      = "vault-unseal-script"
    namespace = var.namespace
  }

  data = {
    "unseal.sh" = file("${path.module}/scripts/unseal.sh")
  }
  depends_on = [
    helm_release.vault
  ]
}

resource "kubectl_manifest" "vault_unseal_serviceaccount" {
  validate_schema = false
  yaml_body = templatefile("${path.module}/templates/vault-unseal-serviceaccount.yaml.tpl",
    local.values_vault
  )
}

#Job for script
resource "kubernetes_job" "vault_unseal" {
  metadata {
    name      = "vault-unseal"
    namespace = var.namespace
  }
  wait_for_completion = true
  timeouts {
    create = "10m"
    update = "10m"
  }
  spec {
    template {
      metadata {
        name = "vault-unseal"
      }

      spec {
        restart_policy       = "OnFailure"
        service_account_name = "vault-unseal"
        container {
          name  = "vault-unseal"
          image = "bitnami/kubectl:latest"
          command = [
            "/bin/bash", "/scripts/unseal.sh",
            var.namespace,
            var.vault_secret_name,
            var.vault_replicas
          ]

          volume_mount {
            name       = "script-volume"
            mount_path = "/scripts/unseal.sh"
            sub_path   = "unseal.sh"
          }
        }

        volume {
          name = "script-volume"

          config_map {
            name = kubernetes_config_map.vault_unseal_script.metadata[0].name

            items {
              key  = "unseal.sh"
              path = "unseal.sh"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.vault,
    kubernetes_config_map.vault_unseal_script,
    kubectl_manifest.vault_unseal_role,
    kubectl_manifest.vault_unseal_rolebinding,
    kubectl_manifest.vault_unseal_serviceaccount
  ]
}

# Configmap
resource "kubernetes_config_map" "vault_enable_auth_script" {
  metadata {
    name      = "vault-enable-auth-script"
    namespace = var.namespace
  }

  data = {
    "enable_auth.sh" = file("${path.module}/scripts/enable_auth.sh")
  }
  depends_on = [
    helm_release.vault
  ]
}

#Job for script
resource "kubernetes_job" "vault_enable_auth" {
  metadata {
    name      = "vault-enable-auth"
    namespace = var.namespace
  }
  wait_for_completion = true
  timeouts {
    create = "10m"
    update = "10m"
  }
  spec {
    template {
      metadata {
        name = "vault-enable-auth"
      }

      spec {
        restart_policy       = "OnFailure"
        service_account_name = "vault-unseal"
        container {
          name  = "vault-enable-auth"
          image = "bitnami/kubectl:latest"
          command = [
            "/bin/bash", "/scripts/enable_auth.sh",
            var.namespace,
            var.vault_secret_name,
            var.vault_replicas
          ]
          env {
            name  = "VAULT_NAMESPACE"
            value = var.namespace
          }
          
          volume_mount {
            name       = "script-volume"
            mount_path = "/scripts/enable_auth.sh"
            sub_path   = "enable_auth.sh"
          }
        }

        volume {
          name = "script-volume"

          config_map {
            name = kubernetes_config_map.vault_enable_auth_script.metadata[0].name

            items {
              key  = "enable_auth.sh"
              path = "enable_auth.sh"
            }
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.vault,
    kubectl_manifest.vault_unseal_role,
    kubectl_manifest.vault_unseal_rolebinding,
    kubectl_manifest.vault_unseal_serviceaccount,
    kubernetes_config_map.vault_unseal_script,
    kubernetes_job.vault_unseal,
    kubernetes_config_map.vault_enable_auth_script
  ]
}
