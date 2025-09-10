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

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID."
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
  type        = map(object({
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


########################################
# Storage Account settings
########################################
variable "storage_account_account_tier" {
  description = "Storage Account tier (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "storage_account_account_replication_type" {
  description = "Replication type (e.g., LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)."
  type        = string
  default     = "LRS"
}

variable "storage_account_account_kind" {
  description = "Account kind (Storage, StorageV2, BlobStorage)."
  type        = string
  default     = "StorageV2"
}

variable "storage_account_access_tier" {
  description = "Blob access tier (Hot or Cool)."
  type        = string
  default     = "Hot"
}

## Storage Account alert toggles
variable "storage_alert_availability_enabled" {
  type        = bool
  default     = false
  description = "Enable Storage Account Availability alert."
}

variable "storage_alert_success_server_latency_enabled" {
  type        = bool
  default     = false
  description = "Enable Storage Account SuccessServerLatency alert."
}

variable "storage_alert_used_capacity_enabled" {
  type        = bool
  default     = false
  description = "Enable Storage Account UsedCapacity alert."
}

########################################
# SQL Server settings
########################################
variable "serial_number" {
  description = "Serial suffix for the SQL Server name (used in azpds<env-initial><serial>)."
  type        = string
}

variable "administrator_login" {
  description = "SQL administrator login for the server."
  type        = string
}

variable "administrator_login_password" {
  description = "SQL administrator password for the server."
  type        = string
  sensitive   = true
}

variable "entra_admin_object_id" {
  description = "Object ID (User/Group/SP) for Microsoft Entra administrator on SQL Server and database."
  type        = string
}

variable "entra_admin_login_name" {
  description = "Display name (or UPN) of the Entra admin group/user."
  type        = string
}

########################################
# SQL Database settings
########################################
variable "sql_database_name" {
  description = "SQL Database name."
  type        = string
}

variable "sql_database_sku_name" {
  description = "SQL Database SKU (e.g., GP_S_Gen5_2, S0, P1)."
  type        = string
  default     = "S0"
}

variable "sql_database_min_capacity" {
  description = "Minimum capacity for serverless SKUs. Null to omit."
  type        = number
  default     = null
}

variable "sql_database_auto_pause_delay_in_minutes" {
  description = "Optional auto-pause delay (minutes) for Serverless SQL Database SKUs. Set null to omit."
  type        = number
  default     = null
}

variable "sql_database_zone_redundant" {
  description = "Enable zone redundancy for SQL Database."
  type        = bool
  default     = false
}

variable "sql_database_backup_interval_in_hours" {
  description = "Differential backup interval (0 to omit)."
  type        = number
  default     = 0
}

variable "sql_database_pitr_days" {
  description = "Point-in-time restore retention days (PITR)."
  type        = number
  default     = 7
}

variable "sql_database_weekly_ltr_weeks" {
  description = "Weekly LTR retention (weeks). 0 to disable."
  type        = number
  default     = 0
}

variable "sql_database_monthly_ltr_months" {
  description = "Monthly LTR retention (months). 0 to disable."
  type        = number
  default     = 0
}

variable "sql_database_yearly_ltr_years" {
  description = "Yearly LTR retention (years). 0 to disable."
  type        = number
  default     = 0
}

## SQL Database alert toggles
variable "sql_db_alert_availability_enabled" {
  type        = bool
  default     = false
  description = "Enable SQL Database Availability alert."
}

variable "sql_db_alert_app_cpu_percent_enabled" {
  type        = bool
  default     = false
  description = "Enable SQL Database App CPU Percent alert."
}

variable "sql_db_alert_app_memory_percent_enabled" {
  type        = bool
  default     = false
  description = "Enable SQL Database App Memory Percent alert."
}

variable "sql_db_alert_instance_cpu_percent_enabled" {
  type        = bool
  default     = false
  description = "Enable SQL Database Instance CPU Percent alert."
}

variable "sql_db_alert_instance_memory_percent_enabled" {
  type        = bool
  default     = false
  description = "Enable SQL Database Instance Memory Percent alert."
}

variable "sql_db_alert_storage_percent_enabled" {
  type        = bool
  default     = false
  description = "Enable SQL Database Storage Percent alert."
}
