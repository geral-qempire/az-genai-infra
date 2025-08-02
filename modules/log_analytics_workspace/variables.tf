variable "name" {
  description = "(Required) Name of the Log Analytics workspace."
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "The 'name' must be a non-empty string."
  }
}

variable "resource_group_name" {
  description = "(Required) Resource group in which to create the workspace."
  type        = string
}

variable "location" {
  description = "(Required) Azure location where the workspace will be created, e.g. 'westeurope'."
  type        = string
}

variable "retention_in_days" {
  description = "(Optional) Workspace data retention in days. Valid values are 30 to 730 for PerGB2018."
  type        = number
  default     = 30

  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "retention_in_days must be between 30 and 730 days (inclusive) for the PerGB2018 SKU."
  }
}

variable "tags" {
  description = "(Optional) Tags to apply to the workspace."
  type        = map(string)
  default     = {}
}
