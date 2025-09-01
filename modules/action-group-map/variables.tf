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
  description = "Azure region for the deployment."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which to create the action group."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations. Recommended to pass from the shared modules/region-abbreviations module."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether the action group is enabled."
}

variable "email_receivers" {
  description = "Map of email receivers to add to the action group, keyed by receiver name."
  type = map(object({
    email_address = string
  }))
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to the action group."
}
