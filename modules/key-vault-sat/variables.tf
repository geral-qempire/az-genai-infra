variable "name" {
  description = "(Optional) Name of the metric alert. If not provided, defaults to alrt-sat-<resource-name>."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "(Required) Resource group in which to create the alert."
  type        = string
}

variable "scopes" {
  description = <<DESC
(Required) List of resource IDs that the alert monitors.
For Key Vault SaturationShoebox, pass one or more Key Vault resource IDs (Microsoft.KeyVault/vaults).
DESC
  type = list(string)

  validation {
    condition     = length(var.scopes) >= 1
    error_message = "Provide at least one scope (Key Vault resource ID)."
  }
}

variable "threshold" {
  description = <<DESC
(Optional) Vault capacity used threshold percentage.
Alert fires when the metric average over the window is greater than this value.
DESC
  type    = number
  default = 75

  validation {
    condition     = var.threshold >= 0 && var.threshold <= 100
    error_message = "threshold must be between 0 and 100."
  }
}

variable "description" {
  description = "(Optional) Description for the alert."
  type        = string
  default     = null
}

variable "enabled" {
  description = "(Optional) Whether the alert is enabled."
  type        = bool
  default     = true
}

variable "action_group_ids" {
  description = "(Optional) Action Group IDs to notify when the alert fires."
  type        = list(string)
  default     = []
}

variable "auto_mitigate" {
  description = "(Optional) Whether the alert should auto mitigate when conditions clear."
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) Tags to apply to the metric alert resource."
  type        = map(string)
  default     = {}
}


