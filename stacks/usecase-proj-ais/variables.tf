/* providers are configured at the infra layer */

variable "environment" {
  description = "Environment project (dev, qua or prd)"
  type        = string
}

variable "service_prefix" {
  description = "Prefix or name of the project"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources."
  type        = string
}

# Network (for private endpoints)
variable "subnet_name" {
  type        = string
  description = "Subnet name for private endpoints."
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name containing the subnet."
}

variable "dns_resource_group_name" {
  type        = string
  description = "Resource group with Private DNS zone for AI Services."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Resource group name that contains the VNet."
}

# Framework core
variable "framework_resource_group_name" {
  type        = string
  description = "Resource group where the framework hub and resources live."
}

variable "framework_hub_name" {
  type        = string
  description = "Existing AI Hub (workspace) name."
}

variable "framework_storage_account_name" {
  type        = string
  description = "Existing Storage Account name (optional, for reference)."
}

variable "framework_ai_search_name" {
  type        = string
  description = "Existing AI Search name (optional, for reference)."
}

# Optional tags
variable "tags" {
  description = "Optional tags to add to resources."
  type        = map(string)
  default     = {}
}

## AD Group IDs for RBAC (optional)
variable "ad_read_group_id" {
  type        = string
  default     = null
  description = "Object ID of the Entra ID group to grant read-level roles. If null, no read group RBAC is created."
}

variable "ad_full_group_id" {
  type        = string
  default     = null
  description = "Object ID of the Entra ID group to grant full-level roles. If null, no full group RBAC is created."
}

## Service Principal IDs for RBAC (optional)
variable "sp_cicd_id" {
  type        = string
  default     = null
  description = "Object ID of the CI/CD service principal. If null, no CI/CD SP RBAC is created."
}

variable "sp_app_id" {
  type        = string
  default     = null
  description = "Object ID of the application service principal. If null, no App SP RBAC is created."
}

variable "ai_services_sku_name" {
  description = "AI Services SKU."
  type        = string
  default     = "S0"
}

variable "ai_services_model_deployment_names" {
  type        = list(string)
  description = "Azure OpenAI model deployment names used by AI Services alerts."
  default     = []
}

variable "ai_services_alert_availability_rate_enabled" {
  type        = bool
  default     = false
  description = "Enable AzureOpenAIAvailabilityRate alert."
}

variable "ai_services_alert_normalized_ttft_enabled" {
  type        = bool
  default     = false
  description = "Enable AzureOpenAINormalizedTTFTInMS alert."
}

variable "ai_services_alert_ttlt_enabled" {
  type        = bool
  default     = false
  description = "Enable AzureOpenAITTLTInMS alert."
}

variable "ai_services_alert_processed_tokens_enabled" {
  type        = bool
  default     = false
  description = "Enable ProcessedInferenceTokens alert."
}

variable "action_group_id" {
  type        = string
  description = "Resource ID of an Azure Monitor Action Group to notify for all alerts."
  default     = null
}

# Optional: Action Group via emails (single action group with multiple emails)
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
  description = "Map of email receivers for the action group."
}

variable "action_group_emails" {
  type        = list(string)
  default     = []
  description = "List of email addresses for the action group."
}



