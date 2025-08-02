variable "name" {
  description = "(Required) Name of the Application Insights resource."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Resource group in which to create the resource."
  type        = string
}

variable "location" {
  description = "(Required) Azure region, e.g. 'westeurope'."
  type        = string
}

variable "application_type" {
  description = <<DESC
(Required) Type of application. Common values are "web" or "other".
DESC
  type = string

  validation {
    condition     = contains(["web", "other"], lower(var.application_type))
    error_message = "application_type must be 'web' or 'other'."
  }
}

variable "daily_data_cap_in_gb" {
  description = <<DESC
(Optional) The daily data volume cap (in GB). Set to null to leave at the platform default.
DESC
  type    = number
  default = null

  validation {
    condition     = var.daily_data_cap_in_gb == null || (var.daily_data_cap_in_gb >= 0 && var.daily_data_cap_in_gb <= 1000)
    error_message = "daily_data_cap_in_gb must be null or between 0 and 1000."
  }
}

variable "retention_days" {
  description = <<DESC
(Optional) Data retention in days for classic (non-workspace-based) Application Insights. 
Valid values typically range from 30 to 730. For workspace-based Application Insights, retention is controlled by the Log Analytics workspace.
DESC
  type    = number
  default = 90

  validation {
    condition     = var.retention_days == null || (var.retention_days >= 30 && var.retention_days <= 730)
    error_message = "retention_days must be between 30 and 730, or null."
  }
}

variable "sampling_percentage" {
  description = <<DESC
(Optional) Percentage of telemetry sampled (0–100). 100 means no sampling (ingest all).
DESC
  type    = number
  default = 100

  validation {
    condition     = var.sampling_percentage >= 0 && var.sampling_percentage <= 100
    error_message = "sampling_percentage must be between 0 and 100."
  }
}

variable "tags" {
  description = "(Optional) Tags to apply to the resource."
  type        = map(string)
  default     = {}
}
