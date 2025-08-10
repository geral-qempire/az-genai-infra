variable "infra_subscription_id" {
  description = "Subscription ID where resources are deployed."
  type        = string
}

variable "dns_subscription_id" {
  description = "Subscription ID that hosts Private DNS Zones."
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources."
  type        = string
  default     = "westeurope"
}

variable "dns_resource_group_name" {
  description = "Resource group name containing required Private DNS Zones."
  type        = string
}

variable "service_prefix" {
  description = "Project prefix for resource names."
  type        = string
  default     = "qempire"
}

variable "environment" {
  description = "Environment identifier (dev/qua/prd)."
  type        = string
  default     = "dev"
}

variable "vnet_resource_group_name" {
  description = "Resource group name of the existing Virtual Network."
  type        = string
}

variable "vnet_name" {
  description = "Name of the existing Virtual Network."
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing Subnet to use for Private Endpoints."
  type        = string
}

variable "private_endpoint_location" {
  description = "Azure region to deploy Private Endpoints (must match the subnet's region)."
  type        = string
}

# Log Analytics Workspace settings
variable "law_sku" {
  description = "Log Analytics Workspace SKU."
  type        = string
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  description = "Log Analytics data retention in days."
  type        = number
  default     = 30
}

variable "law_daily_quota_gb" {
  description = "Log Analytics daily quota in GB (0 for unlimited)."
  type        = number
  default     = 0
}

# Storage account settings
variable "sa_account_tier" {
  description = "Storage account tier."
  type        = string
  default     = "Standard"
}

variable "sa_account_replication_type" {
  description = "Storage account replication type."
  type        = string
  default     = "LRS"
}

variable "sa_account_kind" {
  description = "Storage account kind."
  type        = string
  default     = "StorageV2"
}

variable "sa_access_tier" {
  description = "Storage account access tier."
  type        = string
  default     = "Hot"
}

variable "sa_public_network_access_enabled" {
  description = "Allow public network access to the storage account."
  type        = bool
  default     = false
}

variable "sa_shared_access_key_enabled" {
  description = "Enable shared access keys for the storage account."
  type        = bool
  default     = true
}

variable "sa_infrastructure_encryption_enabled" {
  description = "Enable infrastructure encryption for the storage account."
  type        = bool
  default     = false
}

variable "sa_enable_private_endpoint_blob" {
  description = "Create private endpoint for Blob."
  type        = bool
  default     = true
}

variable "sa_enable_private_endpoint_file" {
  description = "Create private endpoint for File."
  type        = bool
  default     = false
}

variable "sa_enable_private_endpoint_queue" {
  description = "Create private endpoint for Queue."
  type        = bool
  default     = false
}

variable "sa_enable_private_endpoint_table" {
  description = "Create private endpoint for Table."
  type        = bool
  default     = false
}

variable "sa_enable_private_endpoint_dfs" {
  description = "Create private endpoint for DFS (Data Lake Gen2)."
  type        = bool
  default     = false
}

### SQL Server settings

variable "sql_serial_number" {
  description = "Required serial number suffix for SQL Server name (azpds<env-initial><serial>)."
  type        = string
}

variable "sql_admin_login" {
  description = "SQL Server administrator login."
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server administrator password."
  type        = string
  sensitive   = true
}

variable "sql_entra_admin_login_name" {
  description = "Microsoft Entra administrator login name (UPN/display name). Optional."
  type        = string
  default     = ""
}

variable "sql_entra_admin_object_id" {
  description = "Microsoft Entra administrator object id. Optional."
  type        = string
  default     = ""
}

variable "sql_entra_admin_tenant_id" {
  description = "Tenant id for Entra admin. Optional; defaults to current tenant."
  type        = string
  default     = ""
}

variable "sql_version" {
  description = "SQL Server version."
  type        = string
  default     = "12.0"
}

variable "sql_minimum_tls_version" {
  description = "Minimum TLS version for SQL Server."
  type        = string
  default     = "1.2"
}

variable "sql_public_network_access_enabled" {
  description = "Allow public network access to SQL Server."
  type        = bool
  default     = false
}

variable "sql_enable_private_endpoint" {
  description = "Create Private Endpoint for SQL Server."
  type        = bool
  default     = true
}

variable "sql_identity" {
  description = "Managed identity for SQL Server."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = {
    type = "SystemAssigned"
  }
}

### SQL Database settings

variable "sql_db_name" {
  description = "Name of the SQL database."
  type        = string
  default     = "appdb"
}

variable "sql_db_sku_name" {
  description = "SKU name of the SQL Database (e.g., S0, GP_S_Gen5_2)."
  type        = string
  default     = "S0"
}

variable "sql_db_min_capacity" {
  description = "Optional minimum capacity (vCores) for Serverless SKUs."
  type        = number
  default     = null
}

variable "sql_db_auto_pause_delay_in_minutes" {
  description = "Optional auto pause delay in minutes for Serverless SKUs."
  type        = number
  default     = null
}

variable "sql_db_collation" {
  description = "Database collation."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sql_db_zone_redundant" {
  description = "Whether the database is zone redundant."
  type        = bool
  default     = false
}

variable "sql_db_pitr_days" {
  description = "PITR retention days."
  type        = number
  default     = 7
}

variable "sql_db_backup_interval_in_hours" {
  description = "Differential backup interval in hours for short-term retention (0 to omit)."
  type        = number
  default     = 0
}

variable "sql_db_weekly_ltr_weeks" {
  description = "Weekly LTR retention in weeks (0 to disable)."
  type        = number
  default     = 0
}

variable "sql_db_monthly_ltr_months" {
  description = "Monthly LTR retention in months (0 to disable)."
  type        = number
  default     = 0
}

variable "sql_db_yearly_ltr_years" {
  description = "Yearly LTR retention in years (0 to disable)."
  type        = number
  default     = 0
}

### Identities

variable "kv_identity" {
  description = "Managed identity for Key Vault."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = {
    type = "SystemAssigned"
  }
}

variable "sa_identity" {
  description = "Managed identity for Storage Account."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = {
    type = "SystemAssigned"
  }
}

variable "ais_identity" {
  description = "Managed identity for AI Services."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = {
    type = "SystemAssigned"
  }
}

# AI Services alert requirements
variable "ai_model_deployment_names" {
  description = "List of model deployment names to use in AI Services alert modules."
  type        = list(string)
  default     = ["gpt-4o-mini"]
}



