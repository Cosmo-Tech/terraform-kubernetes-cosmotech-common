variable "create_prometheus_stack" {
  type    = bool
  default = true
}

variable "prom_cpu_mem_limits" {
  type = string
}

variable "prom_cpu_mem_request" {
  type = string
}