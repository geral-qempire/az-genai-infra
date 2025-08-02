variable "name_prefix" {
  description = "Base prefix used to build the resource group and Application Insights names."
  type        = string
  default     = "test"
}

variable "location" {
  description = "Azure region to deploy resources into (e.g., westeurope)."
  type        = string
  default     = "westeurope"
}

variable "application_type" {
  description = "Type of application. Valid values: web, other."
  type        = string
  default     = "web"
}

variable "retention_days" {
  description = "Data retention for the Application Insights (30..730 days)."
  type        = number
  default     = 90
}

variable "sampling_percentage" {
  description = "Percentage of telemetry sampled (0-100). 100 means no sampling."
  type        = number
  default     = 100
}

variable "daily_data_cap_in_gb" {
  description = "Daily data volume cap in GB. Set to null for platform default."
  type        = number
  default     = null
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    environment = "test"
    owner       = "platform-team"
  }
}

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