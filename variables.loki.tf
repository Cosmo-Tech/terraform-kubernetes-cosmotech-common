variable "loki_deploy" {
  type = bool
}

variable "loki_release_name" {
  type = string
}

variable "loki_persistence_memory" {
  type = string
}

variable "loki_retention_period" {
  type = string
}

variable "loki_helm_repo_url" {
  type = string
}

variable "loki_helm_chart" {
  type = string
}

variable "loki_helm_chart_version" {
  type = string
}

variable "loki_max_entries_limet_per_query" {
  type = number
}

variable "grafana_loki_compatibility_image_tag" {
  type = string
}

variable "loki_resources" {
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
}
