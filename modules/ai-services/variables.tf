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

########################################
# Alerts - Availability Rate
########################################

variable "enable_availability_rate_alert" {
  type        = bool
  default     = true
  description = "Enable the AzureOpenAIAvailabilityRate metric alert."
}

variable "availability_rate_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the AvailabilityRate alert. Defaults to alrt-avail-<resource-name>."
}

variable "availability_rate_alert_threshold" {
  type        = number
  default     = 90
  description = "Availability rate threshold percentage. Alert fires when below this value."
  validation {
    condition     = var.availability_rate_alert_threshold >= 0 && var.availability_rate_alert_threshold <= 100
    error_message = "threshold must be between 0 and 100."
  }
}

variable "availability_rate_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the AvailabilityRate alert. Auto-generated if not provided."
}

variable "availability_rate_alert_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4). Default is 1."
}

variable "availability_rate_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the AvailabilityRate alert is enabled."
}

variable "availability_rate_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the AvailabilityRate alert should auto mitigate when conditions clear."
}

variable "availability_rate_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the AvailabilityRate alert. Default PT1M."
}

variable "availability_rate_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the AvailabilityRate alert. Default PT5M."
}

variable "availability_rate_alert_operator" {
  type        = string
  default     = "LessThan"
  description = "Operator for the AvailabilityRate alert criteria."
}

variable "availability_rate_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the AvailabilityRate alert criteria."
}

variable "availability_rate_alert_model_deployment_names" {
  type        = list(string)
  default     = ["*"]
  description = "Model deployment names to filter on ModelDeploymentName dimension. Defaults to all deployments."
}

variable "availability_rate_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the AvailabilityRate alert."
}

########################################
# Alerts - Processed Tokens
########################################

variable "enable_processed_tokens_alert" {
  type        = bool
  default     = true
  description = "Enable the Processed Inference Tokens metric alert."
}

variable "processed_tokens_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the ProcessedTokens alert. Defaults to alrt-tok-<resource-name>."
}

variable "processed_tokens_alert_threshold" {
  type        = number
  default     = 10000000
  description = "Token threshold. Alert fires when total tokens over the window exceed this value."
  validation {
    condition     = var.processed_tokens_alert_threshold >= 0
    error_message = "threshold must be greater than or equal to 0 tokens."
  }
}

variable "processed_tokens_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the ProcessedTokens alert. Auto-generated if not provided."
}

variable "processed_tokens_alert_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4). Default is 3."
}

variable "processed_tokens_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the ProcessedTokens alert is enabled."
}

variable "processed_tokens_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the ProcessedTokens alert should auto mitigate when conditions clear."
}

variable "processed_tokens_alert_frequency" {
  type        = string
  default     = "PT5M"
  description = "Evaluation frequency for the ProcessedTokens alert. Default PT5M."
}

variable "processed_tokens_alert_window_size" {
  type        = string
  default     = "PT1H"
  description = "Time window for the ProcessedTokens alert. Default PT1H."
}

variable "processed_tokens_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the ProcessedTokens alert criteria."
}

variable "processed_tokens_alert_aggregation" {
  type        = string
  default     = "Total"
  description = "Aggregation for the ProcessedTokens alert criteria."
}

variable "processed_tokens_alert_model_deployment_names" {
  type        = list(string)
  default     = ["*"]
  description = "Model deployment names to filter on ModelDeploymentName dimension. Defaults to all deployments."
}

variable "processed_tokens_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the ProcessedTokens alert."
}

########################################
# Alerts - Time To First Token
########################################

variable "enable_ttft_alert" {
  type        = bool
  default     = true
  description = "Enable the Time To First Token metric alert."
}

variable "ttft_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the TTFT alert. Defaults to alrt-ttft-<resource-name>."
}

variable "ttft_alert_threshold" {
  type        = number
  default     = 5
  description = "TTFT threshold in milliseconds. Alert fires when average over the window exceeds this value."
  validation {
    condition     = var.ttft_alert_threshold > 0
    error_message = "threshold must be greater than 0 milliseconds."
  }
}

variable "ttft_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the TTFT alert. Auto-generated if not provided."
}

variable "ttft_alert_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4). Default is 2."
}

variable "ttft_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the TTFT alert is enabled."
}

variable "ttft_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the TTFT alert should auto mitigate when conditions clear."
}

variable "ttft_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the TTFT alert. Default PT1M."
}

variable "ttft_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the TTFT alert. Default PT5M."
}

variable "ttft_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the TTFT alert criteria."
}

variable "ttft_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the TTFT alert criteria."
}

variable "ttft_alert_model_deployment_names" {
  type        = list(string)
  default     = ["*"]
  description = "Model deployment names to filter on ModelDeploymentName dimension. Defaults to all deployments."
}

variable "ttft_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the TTFT alert."
}

########################################
# Alerts - Time To Last Token
########################################

variable "enable_ttlt_alert" {
  type        = bool
  default     = true
  description = "Enable the Time To Last Token metric alert."
}

variable "ttlt_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the TTLT alert. Defaults to alrt-ttlt-<resource-name>."
}

variable "ttlt_alert_threshold" {
  type        = number
  default     = 5
  description = "TTLT threshold in milliseconds. Alert fires when average over the window exceeds this value."
  validation {
    condition     = var.ttlt_alert_threshold > 0
    error_message = "threshold must be greater than 0 milliseconds."
  }
}

variable "ttlt_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the TTLT alert. Auto-generated if not provided."
}

variable "ttlt_alert_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4). Default is 2."
}

variable "ttlt_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the TTLT alert is enabled."
}

variable "ttlt_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the TTLT alert should auto mitigate when conditions clear."
}

variable "ttlt_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the TTLT alert. Default PT1M."
}

variable "ttlt_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the TTLT alert. Default PT5M."
}

variable "ttlt_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the TTLT alert criteria."
}

variable "ttlt_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the TTLT alert criteria."
}

variable "ttlt_alert_model_deployment_names" {
  type        = list(string)
  default     = ["*"]
  description = "Model deployment names to filter on ModelDeploymentName dimension. Defaults to all deployments."
}

variable "ttlt_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the TTLT alert."
}


