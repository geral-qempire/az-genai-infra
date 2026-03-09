variable "resource_group_name" {
  type        = string
  description = "Name of the existing Resource Group where the Storage Account will be deployed."
}

variable "service_prefix" {
  type        = string
  description = "Prefix or name of the project"
}

variable "location" {
  type        = string
  description = "Azure region for the deployment."
}

variable "subnet_name" {
  type        = string
  description = "Subnet name for private endpoints."
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name containing the subnet."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Resource group name that contains the VNet."
}

variable "dns_resource_group_name" {
  type        = string
  description = "Resource group name that contains Private DNS zones and the VNet/subnet."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment label (dev, qua, prd). Used for naming where upstream modules require it."
}

variable "tier" {
  type        = string
  default     = "tier1"
  description = "Storage Account tier to deploy. Options: tier1 (LRS, dev workloads) or tier2 (ZRS, qa/prd workloads)."

  validation {
    condition     = contains(["tier1", "tier2"], var.tier)
    error_message = "Tier must be either 'tier1' or 'tier2'."
  }
}

########################################
# Private Endpoints
########################################

variable "enable_private_endpoint_blob" {
  type        = bool
  default     = true
  description = "Enable private endpoint for blob service."
}

variable "enable_private_endpoint_file" {
  type        = bool
  default     = true
  description = "Enable private endpoint for file service."
}

variable "enable_private_endpoint_table" {
  type        = bool
  default     = true
  description = "Enable private endpoint for table service."
}

variable "enable_private_endpoint_queue" {
  type        = bool
  default     = true
  description = "Enable private endpoint for queue service."
}

########################################
# RBAC - User Profiles
########################################

variable "ad_read_group_id" {
  type        = string
  default     = null
  description = "Azure AD Group ID for developers (read access profile). Leave null to skip developer RBAC assignments."
}

variable "ad_full_group_id" {
  type        = string
  default     = null
  description = "Azure AD Group ID for tech leads (full access profile). Leave null to skip tech lead RBAC assignments."
}

########################################
# Action Group
########################################

variable "action_group_enabled" {
  type        = bool
  default     = true
  description = "Whether the action group is enabled."
}

variable "action_group_email_receivers" {
  type = map(object({
    email_address = string
  }))
  default     = {}
  description = "Map of email receivers for the action group, keyed by receiver name."
}

variable "action_group_emails" {
  type        = list(string)
  default     = []
  description = "List of email addresses for the action group. Will be converted to email_receivers map internally."
}

variable "action_group_id" {
  type        = string
  default     = null
  description = "Optional existing action group ID to use for alerts instead of creating a new one."
}

########################################
# Tags
########################################

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources created by this template."
}

