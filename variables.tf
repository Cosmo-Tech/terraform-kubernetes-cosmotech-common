# Common environment variables
variable "cluster_issuer_email" {
  type = string
}

variable "cluster_issuer_name" {
  type    = string
  default = "letsencrypt-prod"
}

variable "tls_secret_name" {
  type    = string
  default = "letsencrypt-prod"
}

variable "tls_certificate_type" {
  type    = string
  default = "let_s_encrypt"
  validation {
    condition = contains([
      "let_s_encrypt",
      "custom",
      "none"
    ], var.tls_certificate_type)
    error_message = "Only let_s_encrypt and none are supported for tls_certificate_type."
  }
}

variable "namespace" {
  type = string
}

variable "monitoring_namespace" {
  type    = string
  default = "cosmotech-monitoring"
}

variable "ingress_nginx_version" {
  type    = string
  default = "4.2.5"
}

variable "create_prometheus_stack" {
  type    = bool
  default = true
}

variable "publicip_resource_group" {
  type = string
}

variable "api_dns_name" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "loadbalancer_ip" {
  type = string
}

variable "certificate_cert_content" {
  type = string
}

variable "certificate_key_content" {
  type = string
}

variable "loki_release_name" {
  type    = string
  default = "loki"
}
variable "loki_persistence_memory" {
  type    = string
  default = "4Gi"
}

variable "loki_retention_period" {
  type    = string
  default = "720h"
}

variable "helm_repo_url" {
  type    = string
  default = "https://grafana.github.io/helm-charts"
}

variable "helm_chart" {
  type    = string
  default = "loki-stack"
}

variable "loki_max_entries_limet_per_query" {
  type    = number
  default = 50000
}

variable "prom_cpu_mem_limits" {
  type = string
}

variable "prom_cpu_mem_request" {
  type = string
}


variable "grafana_loki_compatibility_image_tag" {
  type = string
}

variable "is_bare_metal" {
  type = bool
}

variable "resources" {
  type = list(object({
    name         = string
    storage      = string
    labels       = map(string)
    access_modes = list(string)
    path         = string
  }))
  description = <<EOT
  Values for the persistent volume and persistent volume claims when in 
  a bare metal context and provisioner is set to local-path.
  If a provisioner is available, set the provisioner variable to the 
  value of the StorageClass for this provisioner.
  EOT
  default = [{

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
    }
  ]
}

variable "provisioner" {
  type        = string
  default     = ""
  description = "Value for the provisioner key in the storage class. If in a bare metal environment and no provisioner available, set this to 'local-path'"
}

variable "create_keycloak" {
  type = bool
}

variable "argo_workflows_app_version" {
  type        = string
  default     = "v3.5.8"
  description = "The argo-workflows application version to install (not the Helm chart version !)"
}

variable "argo_workflows_crds_list" {
  type        = list(string)
  description = <<EOT
  List of Argo Workflows CRDs to install. Should match the list of 
  CRDs for the specific version of the application.
  The pattern of the URL to check is something like:
  "https://raw.githubusercontent.com/argoproj/argo-workflows/<APP_VERSION>/manifests/base/crds/minimal"
  EOT
  default = [
    "argoproj.io_clusterworkflowtemplates.yaml",
    "argoproj.io_cronworkflows.yaml",
    "argoproj.io_workflowartifactgctasks.yaml",
    "argoproj.io_workfloweventbindings.yaml",
    "argoproj.io_workflows.yaml",
    "argoproj.io_workflowtaskresults.yaml",
    "argoproj.io_workflowtasksets.yaml",
    "argoproj.io_workflowtemplates.yaml"
  ]
}