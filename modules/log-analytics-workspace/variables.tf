variable "environment" {
  type        = string
  description = "Environment project (dev, qua or prd)"
}

variable "service_prefix" {
  type        = string
  description = "Prefix or name of the project"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Log Analytics Workspace should exist."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations. Recommended to pass from the shared modules/region-abbreviations module."
}

variable "sku" {
  type        = string
  default     = "PerGB2018"
  description = "The SKU of the Log Analytics Workspace. Common values: PerGB2018, Free, Standalone, CapacityReservation."
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "The workspace data retention in days. Valid values: 7 to 730."
}

variable "daily_quota_gb" {
  type        = number
  default     = -1
  description = "The daily cap on data ingestion in GB. -1 means unlimited."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}


