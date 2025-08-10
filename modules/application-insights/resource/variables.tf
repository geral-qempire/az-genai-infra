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
  description = "Azure region for the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which to create the resource."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations. Recommended to pass from the shared modules/region-abbreviations module."
}

variable "application_type" {
  type        = string
  default     = "web"
  description = "Specifies the type of Application Insights. Valid values: web, other."
}

variable "workspace_id" {
  type        = string
  default     = ""
  description = "Optional Log Analytics Workspace ID to link to. If empty, creates a classic (non-workspace-based) instance."
}

variable "internet_ingestion_enabled" {
  type        = bool
  default     = true
  description = "Should the Application Insights component support ingestion over the Public Internet?"
}

variable "internet_query_enabled" {
  type        = bool
  default     = true
  description = "Should the Application Insights component support querying over the Public Internet?"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}


