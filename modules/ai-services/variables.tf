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
  description = "The name of the Resource Group where the AI Services should exist."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations."
}

variable "sku_name" {
  type        = string
  default     = "S0"
  description = "Specifies the SKU Name for the AI Services account."
}

variable "local_authentication_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the AI Services allows authenticating using API Keys?"
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

variable "network_acls_bypass" {
  type        = string
  default     = "None"
  description = "Specifies which traffic can bypass the network rules for AI Services. Possible values are None or AzureServices."

  validation {
    condition     = contains(["None", "AzureServices"], var.network_acls_bypass)
    error_message = "Possible values for network_acls_bypass are None or AzureServices."
  }
}

variable "custom_subdomain_name" {
  type        = string
  default     = ""
  description = "Optional custom subdomain name. If empty, a default will be generated."
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

variable "storage_account" {
  type = object({
    storage_account_id = string
    identity_client_id = optional(string)
  })
  default     = null
  description = "Optional storage account configuration for AI Services."
}

variable "enable_private_endpoint" {
  type        = bool
  default     = true
  description = "Create a private endpoint to the AI Services."
}

variable "dns_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group name containing the Private DNS zone for AI Services."
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}


