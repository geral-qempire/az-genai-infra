variable "service_prefix" {
  type        = string
  description = "Prefix or name of the project"
}



variable "location" {
  type        = string
  description = "Azure region for the deployment."
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID."
}

variable "subnet_name" {
  type        = string
  description = "Subnet name for private endpoints."
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name containing the subnet."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Resource group name that contains the VNet."
}

variable "dns_resource_group_name" {
  type        = string
  description = "Resource group name that contains Private DNS zones and the VNet/subnet."
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Name of the existing Log Analytics Workspace to link to."
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "Resource group of the existing Log Analytics Workspace."
}

# Derived and conventional environment. Keep simple; caller can override if needed later.
variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment label (dev, qua, prd). Used for naming where upstream modules require it."
}

# SQL Server settings
variable "serial_number" {
  type        = string
  description = "Serial suffix for the SQL Server name (used in azpds<env-initial><serial>)."
}

variable "administrator_login" {
  type        = string
  description = "SQL administrator login for the server."
}

variable "administrator_login_password" {
  type        = string
  sensitive   = true
  description = "SQL administrator password for the server."
}

variable "entra_admin_object_id" {
  type        = string
  description = "Object ID (User/Group/SP) for Microsoft Entra administrator on SQL Server and database."
}

variable "entra_admin_login_name" {
  type        = string
  description = "Display name (or UPN) of the Entra admin group/user."
}

# SQL Database settings
variable "sql_database_name" {
  type        = string
  description = "SQL Database name."
}

variable "sql_database_sku_name" {
  type        = string
  default     = "S0"
  description = "SQL Database SKU (e.g., GP_S_Gen5_2, S0, P1)."
}

variable "sql_database_min_capacity" {
  type        = number
  default     = null
  description = "Minimum capacity for serverless SKUs. Null to omit."
}

variable "sql_database_auto_pause_delay_in_minutes" {
  type        = number
  default     = null
  description = "Optional auto-pause delay (minutes) for Serverless SQL Database SKUs. Set null to omit."
}

variable "sql_database_zone_redundant" {
  type        = bool
  default     = false
  description = "Enable zone redundancy for SQL Database."
}

variable "sql_database_backup_interval_in_hours" {
  type        = number
  default     = 0
  description = "Differential backup interval (0 to omit)."
}

variable "sql_database_pitr_days" {
  type        = number
  default     = 7
  description = "Point-in-time restore retention days (PITR)."
}

variable "sql_database_weekly_ltr_weeks" {
  type        = number
  default     = 0
  description = "Weekly LTR retention (weeks). 0 to disable."
}

variable "sql_database_monthly_ltr_months" {
  type        = number
  default     = 0
  description = "Monthly LTR retention (months). 0 to disable."
}

variable "sql_database_yearly_ltr_years" {
  type        = number
  default     = 0
  description = "Yearly LTR retention (years). 0 to disable."
}

variable "sql_database_is_serverless" {
  type        = bool
  default     = true
  description = "Whether the SQL Database is using a serverless SKU. Controls which alerts are available."
}

# Alerts toggle
# SQL Database alert toggles (serverless alerts default to true)
variable "sql_db_alert_availability_enabled" {
  type        = bool
  default     = true
  description = "Enable SQL Database Availability alert."
}

variable "sql_db_alert_app_cpu_percent_enabled" {
  type        = bool
  default     = true
  description = "Enable SQL Database App CPU Percent alert."
}

variable "sql_db_alert_app_memory_percent_enabled" {
  type        = bool
  default     = true
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
  default     = true
  description = "Enable SQL Database Storage Percent alert."
}

# Optional tags
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to resources created by this template."
}

# Storage Account settings
variable "storage_account_account_tier" {
  type        = string
  default     = "Standard"
  description = "Storage Account tier (Standard or Premium)."
}

variable "storage_account_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Replication type (e.g., LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)."
}

variable "storage_account_account_kind" {
  type        = string
  default     = "StorageV2"
  description = "Account kind (Storage, StorageV2, BlobStorage)."
}

variable "storage_account_access_tier" {
  type        = string
  default     = "Hot"
  description = "Blob access tier (Hot or Cool)."
}

# Key Vault settings
variable "key_vault_sku_name" {
  type        = string
  default     = "standard"
  description = "Key Vault SKU (standard or premium)."
}

variable "key_vault_soft_delete_retention_days" {
  type        = number
  default     = 90
  description = "Soft delete retention in days."
}

variable "key_vault_purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Enable purge protection on the Key Vault."
}

# AI Search settings
variable "ai_search_sku" {
  type        = string
  default     = "basic"
  description = "Search Service SKU (e.g., basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2)."
}

variable "ai_search_semantic_search_sku" {
  type        = string
  default     = "free"
  description = "Semantic search SKU (free or standard)."
}

variable "ai_search_replica_count" {
  type        = number
  default     = 0
  description = "Number of replicas (ignored for free SKU)."
}

variable "ai_search_partition_count" {
  type        = number
  default     = 1
  description = "Number of partitions (not allowed for free SKU)."
}

# AI Search alert toggles
variable "ai_search_alert_search_latency_enabled" {
  type        = bool
  default     = true
  description = "Enable AI Search SearchLatency alert."
}

variable "ai_search_alert_throttled_pct_enabled" {
  type        = bool
  default     = true
  description = "Enable AI Search ThrottledSearchQueriesPercentage alert."
}

# AI Services settings
variable "ai_services_sku_name" {
  type        = string
  default     = "S0"
  description = "AI Services SKU name (e.g., S0)."
}

variable "ai_services_soft_delete_retention_days" {
  type        = number
  default     = 0
  description = "Not applicable to AI Services (reserved for Key Vault parity)."
}

variable "ai_services_purge_protection_enabled" {
  type        = bool
  default     = false
  description = "Not applicable to AI Services (reserved for Key Vault parity)."
}

variable "ai_services_model_deployment_names" {
  type        = list(string)
  description = "Azure OpenAI model deployment names used by AI Services alerts."
}

## AI Services alert toggles
variable "ai_services_alert_availability_rate_enabled" {
  type        = bool
  default     = true
  description = "Enable AzureOpenAIAvailabilityRate alert."
}

## Key Vault alert toggles
variable "key_vault_alert_availability_enabled" {
  type        = bool
  default     = true
  description = "Enable Key Vault Availability alert."
}

variable "key_vault_alert_saturation_shoebox_enabled" {
  type        = bool
  default     = true
  description = "Enable Key Vault SaturationShoebox alert."
}

## Storage Account alert toggles
variable "storage_alert_availability_enabled" {
  type        = bool
  default     = true
  description = "Enable Storage Account Availability alert."
}

variable "storage_alert_success_server_latency_enabled" {
  type        = bool
  default     = true
  description = "Enable Storage Account SuccessServerLatency alert."
}

variable "storage_alert_used_capacity_enabled" {
  type        = bool
  default     = true
  description = "Enable Storage Account UsedCapacity alert."
}

variable "ai_services_alert_normalized_ttft_enabled" {
  type        = bool
  default     = true
  description = "Enable AzureOpenAINormalizedTTFTInMS alert."
}

variable "ai_services_alert_ttlt_enabled" {
  type        = bool
  default     = true
  description = "Enable AzureOpenAITTLTInMS alert."
}

variable "ai_services_alert_processed_tokens_enabled" {
  type        = bool
  default     = true
  description = "Enable ProcessedInferenceTokens alert."
}

# AD Group IDs for RBAC
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

# Service Principal IDs for RBAC
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

########################################
# Action Group Configuration
########################################
variable "action_group_emails" {
  type        = list(string)
  default     = []
  description = "List of email addresses for the action group. If empty, no action group is created."
}
