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
  description = "The name of the Resource Group where the Key Vault should exist."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations. Recommended to pass from the shared modules/region-abbreviations module."
}

variable "tenant_id" {
  type        = string
  description = "Azure Entra tenant ID to associate with the Key Vault."
}

### Key Vault Settings

variable "sku_name" {
  type        = string
  default     = "standard"
  description = "Specifies the SKU Name for the Key Vault. Possible values are standard and premium."

  validation {
    condition     = contains(["standard", "premium"], lower(var.sku_name))
    error_message = "Possible values are standard or premium."
  }
}

variable "soft_delete_retention_days" {
  type        = number
  default     = 90
  description = "The number of days that items should be retained for soft delete."
}

variable "purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Is Purge Protection enabled for this Key Vault?"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Public Network Access is allowed for this resource."
}

variable "enable_rbac_authorization" {
  type        = bool
  default     = true
  description = "Specifies whether Azure RBAC authorization is enabled for this Key Vault."
}

variable "enabled_for_deployment" {
  type        = bool
  default     = false
  description = "Allow Virtual Machines to retrieve certificates stored as secrets from the Key Vault."
}

variable "enabled_for_disk_encryption" {
  type        = bool
  default     = false
  description = "Allow Disk Encryption to retrieve secrets from the vault and unwrap keys."
}

variable "enabled_for_template_deployment" {
  type        = bool
  default     = false
  description = "Allow Azure Resource Manager to retrieve secrets from the Key Vault."
}

### Private Endpoint

variable "enable_private_endpoint" {
  type        = bool
  default     = true
  description = "Create a private endpoint to the Key Vault."
}

variable "dns_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group name containing the Private DNS zone for Key Vault (privatelink.vaultcore.azure.net)."
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

### Tags

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}

### Identity

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


