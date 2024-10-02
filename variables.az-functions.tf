variable "start_aks_minutes" {
  type = number
  validation {
    condition = can(regex(var.start_aks_minutes, range(0,60)))
    error_message = "Minutes must be between 0 and 59"
  }
  default = 0
}

variable "start_aks_hours" {
  type = number
  validation {
    condition = can(regex(var.start_aks_minutes, range(0,24)))
    error_message = "Hours must be between 0 and 23"
  }
  default = 5
}