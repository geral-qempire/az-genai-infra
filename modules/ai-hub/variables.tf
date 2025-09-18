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
  description = "The name of the Resource Group where the AI Hub should exist."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations. Recommended to pass from the shared modules/region-abbreviations module."
}

variable "storage_account_id" {
  type        = string
  description = "The ID of an existing Storage Account for the AI Hub."
}

variable "key_vault_id" {
  type        = string
  description = "The ID of an existing Key Vault for the AI Hub."
}

variable "application_insights_id" {
  type        = string
  default     = ""
  description = "Optional Application Insights resource ID to associate with the AI Hub. If empty, none is configured."
}

variable "friendly_name" {
  type        = string
  default     = ""
  description = "Optional friendly display name for the AI Hub."
}

variable "public_network_access" {
  type        = string
  default     = "Disabled"
  description = "Specifies whether Public Network Access is allowed for this resource (Enabled or Disabled)."
  validation {
    condition     = contains(["Enabled", "Disabled"], var.public_network_access)
    error_message = "Possible values are Enabled or Disabled."
  }
}

variable "managed_network" {
  type        = string
  default     = ""
  description = "Optional managed network isolation mode. If empty, managed network is not configured."
  validation {
    condition     = var.managed_network == "" || contains(["Disabled", "AllowInternetOutbound", "AllowOnlyApprovedOutbound"], var.managed_network)
    error_message = "Possible values are Disabled, AllowInternetOutbound, or AllowOnlyApprovedOutbound."
  }
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = {
    type = "SystemAssigned"
  }
  description = "Managed identity configuration. Possible types: SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}

variable "fqdn_rules" {
  type        = list(string)
  default     = []
  description = "Optional list of FQDNs to create outbound rules for (created sequentially)."
}

variable "enable_private_endpoint" {
  type        = bool
  default     = true
  description = "Create a private endpoint to resource"
}

variable "dns_resource_group_name" {
  type        = string
  default     = ""
  description = "DNS zone for the private endpoint."
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "Subnet ID for the private endpoint."
}

variable "private_endpoint_location" {
  type        = string
  default     = ""
  description = "Location to deploy the Private Endpoint. If empty, falls back to module location."
}


