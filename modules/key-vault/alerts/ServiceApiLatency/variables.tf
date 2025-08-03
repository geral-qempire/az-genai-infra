variable "name" {
  description = "(Required) Name of the metric alert."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Resource group in which to create the alert."
  type        = string
}

variable "scopes" {
  description = <<DESC
(Required) List of resource IDs that the alert monitors.
For Key Vault ServiceApiLatency, pass one or more Key Vault resource IDs (Microsoft.KeyVault/vaults).
DESC
  type = list(string)

  validation {
    condition     = length(var.scopes) >= 1
    error_message = "Provide at least one scope (Key Vault resource ID)."
  }
}

variable "threshold" {
  description = <<DESC
(Required) Latency threshold in milliseconds for Key Vault ServiceApiLatency.
Alert fires when the metric average over the window is greater than this value.
DESC
  type = number

  validation {
    condition     = var.threshold > 0
    error_message = "threshold must be greater than 0 milliseconds."
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