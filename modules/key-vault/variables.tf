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

### Network

variable "network_acls_bypass" {
  type        = string
  default     = "None"
  description = "Specifies which traffic can bypass the network rules for Key Vault. Possible values are None or AzureServices."

  validation {
    condition     = contains(["None", "AzureServices"], var.network_acls_bypass)
    error_message = "Possible values for network_acls_bypass are None or AzureServices."
  }
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

########################################
# Alerts - Availability
########################################

variable "enable_availability_alert" {
  type        = bool
  default     = true
  description = "Enable the Key Vault Availability metric alert."
}

variable "availability_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the Availability alert. Defaults to alrt-avail-<resource-name>."
}

variable "availability_alert_threshold" {
  type        = number
  default     = 90
  description = "Availability threshold percentage. Alert fires when below this value."
  validation {
    condition     = var.availability_alert_threshold >= 0 && var.availability_alert_threshold <= 100
    error_message = "threshold must be between 0 and 100."
  }
}

variable "availability_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the Availability alert. Auto-generated if not provided."
}

variable "availability_alert_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4). Default is 1."
}

variable "availability_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the Availability alert is enabled."
}

variable "availability_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the Availability alert should auto mitigate when conditions clear."
}

variable "availability_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the Availability alert. Default PT1M."
}

variable "availability_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the Availability alert. Default PT5M."
}

variable "availability_alert_operator" {
  type        = string
  default     = "LessThan"
  description = "Operator for the Availability alert criteria."
}

variable "availability_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the Availability alert criteria."
}

variable "availability_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the Availability alert."
}

########################################
# Alerts - Saturation
########################################

variable "enable_saturation_alert" {
  type        = bool
  default     = true
  description = "Enable the Key Vault SaturationShoebox metric alert."
}

variable "saturation_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the Saturation alert. Defaults to alrt-sat-<resource-name>."
}

variable "saturation_alert_threshold" {
  type        = number
  default     = 75
  description = "Used capacity threshold percentage. Alert fires when above this value."
  validation {
    condition     = var.saturation_alert_threshold >= 0 && var.saturation_alert_threshold <= 100
    error_message = "threshold must be between 0 and 100."
  }
}

variable "saturation_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the Saturation alert. Auto-generated if not provided."
}

variable "saturation_alert_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4). Default is 1."
}

variable "saturation_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the Saturation alert is enabled."
}

variable "saturation_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the Saturation alert should auto mitigate when conditions clear."
}

variable "saturation_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the Saturation alert. Default PT1M."
}

variable "saturation_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the Saturation alert. Default PT5M."
}

variable "saturation_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the Saturation alert criteria."
}

variable "saturation_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the Saturation alert criteria."
}

variable "saturation_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the Saturation alert."
}


