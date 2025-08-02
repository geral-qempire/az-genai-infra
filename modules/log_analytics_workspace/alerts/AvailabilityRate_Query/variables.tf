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
For AvailabilityRate_Query, pass one or more Log Analytics workspace IDs (Microsoft.OperationalInsights/workspaces).
DESC
  type = list(string)

  validation {
    condition     = length(var.scopes) >= 1
    error_message = "Provide at least one scope (Log Analytics workspace resource ID)."
  }
}

variable "threshold" {
  description = <<DESC
(Required) Percentage threshold for AvailabilityRate_Query.
Alert fires when the metric average over the window is less than this value. Valid range 0..100.
DESC
  type = number

  validation {
    condition     = var.threshold >= 0 && var.threshold <= 100
    error_message = "threshold must be between 0 and 100 (inclusive)."
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
