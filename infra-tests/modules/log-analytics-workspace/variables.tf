variable "name_prefix" {
  description = "Base prefix used to build the resource group and workspace names."
  type        = string
  default     = "test"
}

variable "location" {
  description = "Azure region to deploy resources into (e.g., westeurope)."
  type        = string
  default     = "westeurope"
}

variable "retention_in_days" {
  description = "Data retention for the workspace (30..730 for PerGB2018)."
  type        = number
  default     = 30
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
