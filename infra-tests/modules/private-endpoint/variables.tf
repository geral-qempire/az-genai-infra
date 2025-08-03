variable "name_prefix" {
  description = "Base prefix used to build resource names."
  type        = string
  default     = "test"
}

variable "location" {
  description = "Azure region to deploy resources into (e.g., westeurope)."
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    environment = "test"
    owner       = "platform-team"
  }
}

# Existing VNet and Subnet configuration
variable "vnet_name" {
  description = "Name of the existing Virtual Network."
  type        = string
}

variable "vnet_resource_group_name" {
  description = "Resource group name where the VNet is located."
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing subnet for private endpoints."
  type        = string
}

# DNS Zone configuration
variable "private_dns_zone_name" {
  description = "Name of the existing Private DNS Zone for Key Vault (privatelink.vaultcore.azure.net)."
  type        = string
  default     = "privatelink.vaultcore.azure.net"
}

variable "dns_zone_resource_group_name" {
  description = "Resource group name where the Private DNS Zone is located."
  type        = string
}

# Azure provider configuration
variable "subscription_id" {
  description = "Azure Subscription ID (for main resources)"
  type        = string
  default     = null
}

variable "dns_zone_subscription_id" {
  description = "Azure Subscription ID for Private DNS Zone (can be different from main subscription)"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = null
} 