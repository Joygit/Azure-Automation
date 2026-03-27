variable "resource_group_name" {
  description = "Name of the resource group to create"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "automation_account_name" {
  description = "Name of the Automation Account"
  type        = list(string)
}

# variable "automation_account_id" {
#   description = "ID for the Automation Account"
#   type        = string
# }

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "sku_name" {
  description = "SKU for Automation Account"
  type        = string
  default     = "Basic"
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "local_authentication_enabled" {
  description = "Enable local authentication"
  type        = bool
  default     = false
}

variable "user_assigned_identity_id" {
  description = "User-assigned identity ID"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

# ✅ SYSTEM ASSIGNED IDENTITY
variable "system_assigned_identity" {
  description = "Enable system assigned managed identity"
  type        = bool
  default     = true
}

# ✅ RUNBOOKS (Important)
variable "automation_runbooks" {
  description = "Automation runbooks configuration"
  type = map(map(object({
    name         = string
    runbook_type = string
    runtime      = optional(string)
    content      = optional(string)
    description  = string
    log_verbose  = optional(bool, false)
    log_progress = optional(bool, false)
    file_path    = optional(string)
  })))
  default = {}
}
