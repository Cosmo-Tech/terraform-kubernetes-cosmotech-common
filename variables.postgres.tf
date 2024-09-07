variable "postgres_helm_repo" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "postgres_helm_chart" {
  type    = string
  default = "postgresql"
}

variable "postgres_helm_chart_version" {
  type    = string
  default = "15.5.1"
}