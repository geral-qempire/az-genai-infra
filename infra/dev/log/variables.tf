variable "infra_subscription_id" {
  description = "Subscription ID where resources are deployed."
  type        = string
}

variable "environment" {
  description = "Environment project (dev, qua or prd)"
  type        = string
  default     = "dev"
}

variable "service_prefix" {
  description = "Prefix or name of the project"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources."
  type        = string
}

variable "law_sku" {
  description = "Log Analytics Workspace SKU."
  type        = string
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  description = "Log Analytics data retention in days."
  type        = number
  default     = 30
}

variable "law_daily_quota_gb" {
  description = "Log Analytics daily quota in GB (-1 for unlimited)."
  type        = number
  default     = -1
}

variable "tags" {
  description = "Optional tags to add to resources."
  type        = map(string)
  default     = {}
}

variable "aad_group_genai_engineer_object_id" {
  description = "Object ID of the AAD group for GenAI Engineers"
  type        = string
  default     = null
}

variable "aad_group_genai_techlead_object_id" {
  description = "Object ID of the AAD group for GenAI Tech Leads"
  type        = string
  default     = null
}

 


