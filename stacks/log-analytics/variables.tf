variable "environment" {
  type        = string
  description = "Environment (dev, qua or prd)."
}

variable "service_prefix" {
  type        = string
  description = "Prefix used in resource naming."
}

variable "location" {
  type        = string
  description = "Azure region for all resources."
}

variable "sku" {
  type        = string
  default     = "PerGB2018"
  description = "SKU of the Log Analytics Workspace."
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "Data retention in days (7-730)."
}

variable "daily_quota_gb" {
  type        = number
  default     = -1
  description = "Daily ingestion cap in GB. -1 means unlimited."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to apply to all resources."
}
