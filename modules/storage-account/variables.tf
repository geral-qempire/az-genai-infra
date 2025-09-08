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
  validation {
    condition = length([
      for v in var.network_rules_bypass : v if contains(["AzureServices", "Logging", "Metrics"], v)
    ]) == length(var.network_rules_bypass)
    error_message = "Allowed values for network_rules_bypass are AzureServices, Logging, Metrics. Use an empty list for no bypass."
  }
}

variable "network_rules_default_action" {
  type        = string
  default     = "Deny"
  description = "The default action for network rules. Possible values are Allow or Deny."
}

########################################
# Alerts - Availability
########################################

variable "enable_availability_alert" {
  type        = bool
  default     = true
  description = "Enable the availability metric alert."
}

variable "availability_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the availability alert. Defaults to alrt-avail-<resource-name>."
}

variable "availability_alert_threshold" {
  type        = number
  default     = 100
  description = "Availability threshold percentage. Alert fires when below this value."
}

variable "availability_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the availability alert. Auto-generated if not provided."
}

variable "availability_alert_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4). Default is 1."
}

variable "availability_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the availability alert is enabled."
}

variable "availability_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the availability alert should auto mitigate when conditions clear."
}

variable "availability_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the availability alert. Default PT1M."
}

variable "availability_alert_window_size" {
  type        = string
  default     = "PT1M"
  description = "Time window for the availability alert. Default PT1M."
}

variable "availability_alert_operator" {
  type        = string
  default     = "LessThan"
  description = "Operator for the availability alert criteria."
}

variable "availability_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the availability alert criteria."
}

variable "availability_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the availability alert."
}

########################################
# Alerts - Success Server Latency
########################################

variable "enable_success_server_latency_alert" {
  type        = bool
  default     = true
  description = "Enable the success server latency metric alert."
}

variable "success_server_latency_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the success server latency alert. Defaults to alrt-sslat-<resource-name>."
}

variable "success_server_latency_alert_threshold" {
  type        = number
  default     = 1000
  description = "Latency threshold in milliseconds. Alert fires when above this value."
}

variable "success_server_latency_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the success server latency alert. Auto-generated if not provided."
}

variable "success_server_latency_alert_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4). Default is 2."
}

variable "success_server_latency_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the success server latency alert is enabled."
}

variable "success_server_latency_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the success server latency alert should auto mitigate when conditions clear."
}

variable "success_server_latency_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the success server latency alert. Default PT1M."
}

variable "success_server_latency_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the success server latency alert. Default PT5M."
}

variable "success_server_latency_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the success server latency alert criteria."
}

variable "success_server_latency_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the success server latency alert criteria."
}

variable "success_server_latency_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the success server latency alert."
}

########################################
# Alerts - Used Capacity
########################################

variable "enable_used_capacity_alert" {
  type        = bool
  default     = true
  description = "Enable the used capacity metric alert."
}

variable "used_capacity_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the used capacity alert. Defaults to alrt-used-<resource-name>."
}

variable "used_capacity_alert_threshold" {
  type        = number
  default     = 5e+14
  description = "Used capacity threshold in bytes. Alert fires when above this value."
}

variable "used_capacity_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the used capacity alert. Auto-generated if not provided."
}

variable "used_capacity_alert_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4). Default is 3."
}

variable "used_capacity_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the used capacity alert is enabled."
}

variable "used_capacity_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the used capacity alert should auto mitigate when conditions clear."
}

variable "used_capacity_alert_frequency" {
  type        = string
  default     = "PT1H"
  description = "Evaluation frequency for the used capacity alert. Default PT1H."
}

variable "used_capacity_alert_window_size" {
  type        = string
  default     = "PT1H"
  description = "Time window for the used capacity alert. Default PT1H."
}

variable "used_capacity_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the used capacity alert criteria."
}

variable "used_capacity_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the used capacity alert criteria."
}

variable "used_capacity_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the used capacity alert."
}


