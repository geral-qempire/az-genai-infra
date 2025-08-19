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
  description = "The name of the Resource Group where the Storage Account should exist."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations."
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "The Tier to use for this storage account. Possible values are Standard and Premium."
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "The type of replication to use for this storage account. Possible values include LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "Defines the Kind of account. Possible values are Storage, StorageV2 and BlobStorage."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Possible values are Hot and Cool."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Public Network Access is allowed for this resource."
}

variable "shared_access_key_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the storage account permits Shared Key access."
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  default     = false
  description = "Enables infrastructure encryption."
}

variable "enable_private_endpoint_blob" {
  type        = bool
  default     = true
  description = "Create a private endpoint for blob service."
}

variable "enable_private_endpoint_file" {
  type        = bool
  default     = false
  description = "Create a private endpoint for file service."
}

variable "enable_private_endpoint_queue" {
  type        = bool
  default     = false
  description = "Create a private endpoint for queue service."
}

variable "enable_private_endpoint_table" {
  type        = bool
  default     = false
  description = "Create a private endpoint for table service."
}

variable "enable_private_endpoint_dfs" {
  type        = bool
  default     = false
  description = "Create a private endpoint for dfs (Data Lake Gen2) service."
}

variable "dns_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource Group name containing the Private DNS Zones for storage endpoints."
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "Subnet ID where private endpoints will be deployed."
}

variable "private_endpoint_location" {
  type        = string
  default     = ""
  description = "Location to deploy Private Endpoints. If empty, falls back to module location."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
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


variable "network_rules_bypass" {
  type        = list(string)
  default     = ["AzureServices"]
  description = "List of services which bypass the network rules. Common values include AzureServices, Logging, Metrics, None."
}

variable "network_rules_default_action" {
  type        = string
  default     = "Deny"
  description = "The default action for network rules. Possible values are Allow or Deny."
}


