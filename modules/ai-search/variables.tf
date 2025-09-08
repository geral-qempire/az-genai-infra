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
  description = "The name of the Resource Group where the Search Service should exist. Changing this forces a new AI Foundry Hub to be created."
}

variable "sku" {
  type        = string
  default     = "basic"
  description = "The SKU which should be used for this Search Service."

  validation {
    condition     = contains(["basic", "free", "standard", "standard2", "standard3", "storage_optimized_l1", "storage_optimized_l2"], var.sku)
    error_message = "Possible values include basic, free, standard, standard2, standard3, storage_optimized_l1 and storage_optimized_l2."
  }
}

########################################
# Optional Variables
########################################

variable "partition_count" {
  type        = number
  default     = 1
  description = "Specifies the number of partitions which should be created. This field cannot be set when using a free sku."

  validation {
    condition     = contains([1, 2, 3, 4, 6, 12], var.partition_count)
    error_message = "This field cannot be set when using a free sku. Possible values include 1, 2, 3, 4, 6, or 12."
  }
}

variable "replica_count" {
  type        = number
  default     = 0
  description = "Specifies the number of Replica's which should be created for this Search Service."
}

variable "semantic_search_sku" {
  type        = string
  default     = "free"
  description = "Specifies the Semantic Search SKU which should be used for this Search Service."

  validation {
    condition     = contains(["free", "standard"], var.semantic_search_sku)
    error_message = "Possible values include free and standard."
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
  description = "A identity and possibles values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned."

  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned."
  }
}

variable "hosting_mode" {
  type        = string
  default     = "default"
  description = "Specifies the Hosting Mode, which allows for High Density partitions (that allow for up to 1000 indexes) should be supported."

  validation {
    condition     = contains(["highDensity", "default"], var.hosting_mode)
    error_message = "Possible values are highDensity or default."
  }
}

variable "local_authentication_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the Search Service allows authenticating using API Keys?"
}

variable "api_access" {
  type        = string
  default     = "RBAC"
  description = "Controls how the Search service is accessed: RBAC (Azure AD only), API (API keys), or Both (Azure AD + API keys). Possible values: RBAC, API, Both."
  validation {
    condition     = contains(["RBAC", "API", "Both"], var.api_access)
    error_message = "api_access must be one of: RBAC, API, Both."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "pecifies whether Public Network Access is allowed for this resource."
}

variable "network_rule_bypass_option" {
  type        = string
  default     = "None"
  description = "Specifies which traffic can bypass network rules for AI Search. Allowed values: None, AzureServices."

  validation {
    condition     = contains(["None", "AzureServices"], var.network_rule_bypass_option)
    error_message = "Allowed values for network_rule_bypass_option are None or AzureServices."
  }
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations. Recommended to pass from the shared modules/region-abbreviations module."
}

########################################
# Alerts - SearchLatency
########################################

variable "enable_search_latency_alert" {
  type        = bool
  default     = true
  description = "Enable the SearchLatency metric alert."
}

variable "search_latency_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the SearchLatency alert. Defaults to alrt-lat-<resource-name>."
}

variable "search_latency_alert_threshold" {
  type        = number
  default     = 5
  description = "Latency threshold in milliseconds. Alert fires when Average over window exceeds this value."
}

variable "search_latency_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the SearchLatency alert. Auto-generated if not provided."
}

variable "search_latency_alert_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4). Default is 3."
}

variable "search_latency_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the SearchLatency alert is enabled."
}

variable "search_latency_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the SearchLatency alert should auto mitigate when conditions clear."
}

variable "search_latency_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the SearchLatency alert. Default PT1M."
}

variable "search_latency_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the SearchLatency alert. Default PT5M."
}

variable "search_latency_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the SearchLatency alert criteria."
}

variable "search_latency_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the SearchLatency alert criteria."
}

variable "search_latency_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the SearchLatency alert."
}

########################################
# Alerts - ThrottledSearchQueriesPercentage
########################################

variable "enable_throttled_search_pct_alert" {
  type        = bool
  default     = true
  description = "Enable the ThrottledSearchQueriesPercentage metric alert."
}

variable "throttled_search_pct_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the ThrottledSearchQueriesPercentage alert. Defaults to alrt-thrpct-<resource-name>."
}

variable "throttled_search_pct_alert_threshold" {
  type        = number
  default     = 10
  description = "Percentage threshold. Alert fires when Average over window exceeds this value."
}

variable "throttled_search_pct_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the ThrottledSearchQueriesPercentage alert. Auto-generated if not provided."
}

variable "throttled_search_pct_alert_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4). Default is 3."
}

variable "throttled_search_pct_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the ThrottledSearchQueriesPercentage alert is enabled."
}

variable "throttled_search_pct_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the ThrottledSearchQueriesPercentage alert should auto mitigate when conditions clear."
}

variable "throttled_search_pct_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the ThrottledSearchQueriesPercentage alert. Default PT1M."
}

variable "throttled_search_pct_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the ThrottledSearchQueriesPercentage alert. Default PT5M."
}

variable "throttled_search_pct_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the ThrottledSearchQueriesPercentage alert criteria."
}

variable "throttled_search_pct_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the ThrottledSearchQueriesPercentage alert criteria."
}

variable "throttled_search_pct_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the ThrottledSearchQueriesPercentage alert."
}