# Common environment variables
variable "namespace" {
  type = string
}

variable "monitoring_namespace" {
  type    = string
  default = "cosmotech-monitoring"
}

variable "api_dns_name" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "kube_config" {
  type = string
}

variable "is_bare_metal" {
  type = bool
}

variable "provisioner" {
  type        = string
  default     = ""
  description = "Value for the provisioner key in the storage class. If in a bare metal environment and no provisioner available, set this to 'local-path'"
}
