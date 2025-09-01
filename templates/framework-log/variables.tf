########################################
# Core Configuration
########################################
variable "service_prefix" {
  type        = string
  description = "Prefix or name of the project"
}

variable "location" {
  type        = string
  description = "Azure region for the deployment."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment label (dev, qua, prd). Used for naming where upstream modules require it."
}

variable "infra_subscription_id" {
  type        = string
  description = "Subscription ID where resources are deployed."
}

########################################
# Log Analytics Workspace Settings
########################################
variable "law_sku" {
  type        = string
  default     = "PerGB2018"
  description = "Log Analytics Workspace SKU."
}

variable "law_retention_in_days" {
  type        = number
  default     = 30
  description = "Log Analytics data retention in days."
}

variable "law_daily_quota_gb" {
  type        = number
  default     = -1
  description = "Log Analytics daily quota in GB (-1 for unlimited)."
}

########################################
# RBAC Configuration
########################################
variable "aad_read_access_group" {
  type        = string
  default     = null
  description = "Object ID of the Entra ID group to grant read-level roles. If null, no read group RBAC is created."
}

variable "aad_full_access_group" {
  type        = string
  default     = null
  description = "Object ID of the Entra ID group to grant full-level roles. If null, no full group RBAC is created."
}

########################################
# Optional Configuration
########################################
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to resources created by this template."
}


