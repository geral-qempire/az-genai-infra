variable "name_prefix" {
  description = "Base prefix used to build resource names."
  type        = string
  default     = "test"
}

variable "location" {
  description = "Azure region to deploy resources into (e.g., westeurope)."
  type        = string
  default     = "westeurope"
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention for the Key Vault (7..90 days)."
  type        = number
  default     = 90
}

variable "sku" {
  description = "Key Vault SKU. Valid values: standard, premium."
  type        = string
  default     = "standard"
}

variable "network_rules_bypass" {
  description = "Traffic bypass rules for Key Vault. Valid values: AzureServices, None."
  type        = string
  default     = "AzureServices"
}

variable "availability_threshold" {
  description = "Availability threshold percentage for the alert (0-100). Alert fires when below this value."
  type        = number
  default     = 95
}

variable "saturation_threshold" {
  description = "Saturation threshold percentage for the alert (0-100). Alert fires when above this value."
  type        = number
  default     = 80
}

variable "latency_threshold" {
  description = "Latency threshold in milliseconds for the alert. Alert fires when above this value."
  type        = number
  default     = 1000
}

variable "alert_email_address" {
  description = "Email address to receive alert notifications."
  type        = string
  default     = "platform-team@example.com"
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    environment = "test"
    owner       = "platform-team"
  }
}

# Azure provider configuration
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = null
} 