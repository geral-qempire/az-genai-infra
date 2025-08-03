variable "name" {
  description = "(Required) Name of the Key Vault (globally unique)."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Resource group in which to create the Key Vault."
  type        = string
}

variable "location" {
  description = "(Required) Azure region (e.g., westeurope)."
  type        = string
}

variable "soft_delete_retention_days" {
  description = <<DESC
(Optional) Soft delete retention in days. Azure supports 7–90.
DESC
  type    = number
  default = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90 (inclusive)."
  }
}

variable "sku" {
  description = "(Optional) Key Vault SKU. Allowed values: standard, premium."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], lower(var.sku))
    error_message = "sku must be 'standard' or 'premium'."
  }
}

variable "network_rules_bypass" {
  description = <<DESC
(Optional) Which traffic can bypass network rules. Allowed values: AzureServices, None.
DESC
  type    = string
  default = "AzureServices"

  validation {
    condition     = contains(["AzureServices", "None"], var.network_rules_bypass)
    error_message = "network_rules_bypass must be 'AzureServices' or 'None'."
  }
}

variable "tags" {
  description = "(Optional) Tags to apply to the Key Vault."
  type        = map(string)
  default     = {}
}

variable "tenant_id" {
  description = "(Required) Azure Tenant ID."
  type        = string
}

