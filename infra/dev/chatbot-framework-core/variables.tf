# Subscriptions
variable "infra_subscription_id" { type = string }
variable "dns_subscription_id" { type = string }
variable "tenant_id" { type = string }

# Tags
variable "tags" { type = map(string) }

# Setup
variable "service_prefix" { type = string }
variable "location" { type = string }
variable "environment" { type = string }

# AD Groups
variable "ad_read_group_id" {
  type    = string
  default = null
}
variable "ad_full_group_id" {
  type    = string
  default = null
}

# Service Principals
variable "sp_app_id" {
  type    = string
  default = null
}
variable "sp_cicd_id" {
  type    = string
  default = null
}

# Action Group
variable "action_group_id" {
  type    = string
  default = null
}
variable "action_group_emails" {
  type    = list(string)
  default = []
}

# Network
variable "subnet_name" { type = string }
variable "vnet_name" { type = string }
variable "dns_resource_group_name" { type = string }
variable "vnet_resource_group_name" { type = string }

# Observability
variable "log_analytics_workspace_name" { type = string }
variable "log_analytics_workspace_resource_group_name" { type = string }

# SQL Server
variable "serial_number" { type = string }
variable "administrator_login" { type = string }
variable "administrator_login_password" { type = string }
variable "entra_admin_object_id" { type = string }
variable "entra_admin_login_name" {
  type    = string
  default = ""
}

# SQL Database
variable "sql_database_name" { type = string }
variable "sql_database_sku_name" {
  type    = string
  default = "S0"
}
variable "sql_database_min_capacity" {
  type    = number
  default = null
}
variable "sql_database_auto_pause_delay_in_minutes" {
  type    = number
  default = null
}
variable "sql_database_zone_redundant" {
  type    = bool
  default = false
}
variable "sql_database_pitr_days" {
  type    = number
  default = 7
}
variable "sql_database_backup_interval_in_hours" {
  type    = number
  default = 0
}
variable "sql_database_weekly_ltr_weeks" {
  type    = number
  default = 0
}
variable "sql_database_monthly_ltr_months" {
  type    = number
  default = 0
}
variable "sql_database_yearly_ltr_years" {
  type    = number
  default = 0
}

# Storage Account
variable "storage_account_account_tier" {
  type    = string
  default = "Standard"
}
variable "storage_account_account_replication_type" {
  type    = string
  default = "LRS"
}
variable "storage_account_account_kind" {
  type    = string
  default = "StorageV2"
}
variable "storage_account_access_tier" {
  type    = string
  default = "Hot"
}

# Key Vault
variable "key_vault_sku_name" {
  type    = string
  default = "standard"
}
variable "key_vault_soft_delete_retention_days" {
  type    = number
  default = 90
}
variable "key_vault_purge_protection_enabled" {
  type    = bool
  default = true
}

# AI Search
variable "ai_search_sku" {
  type    = string
  default = "basic"
}
variable "ai_search_semantic_search_sku" {
  type    = string
  default = "free"
}
variable "ai_search_replica_count" {
  type    = number
  default = 0
}
variable "ai_search_partition_count" {
  type    = number
  default = 1
}

# AI Services
variable "ai_services_sku_name" {
  type    = string
  default = "S0"
}
variable "ai_services_model_deployment_names" {
  type    = list(string)
  default = []
}

# Alerts (default false)
variable "sql_db_alert_availability_enabled" {
  type    = bool
  default = false
}
variable "sql_db_alert_app_cpu_percent_enabled" {
  type    = bool
  default = false
}
variable "sql_db_alert_app_memory_percent_enabled" {
  type    = bool
  default = false
}
variable "sql_db_alert_instance_cpu_percent_enabled" {
  type    = bool
  default = false
}
variable "sql_db_alert_instance_memory_percent_enabled" {
  type    = bool
  default = false
}
variable "sql_db_alert_storage_percent_enabled" {
  type    = bool
  default = false
}

variable "storage_alert_availability_enabled" {
  type    = bool
  default = false
}
variable "storage_alert_success_server_latency_enabled" {
  type    = bool
  default = false
}
variable "storage_alert_used_capacity_enabled" {
  type    = bool
  default = false
}

variable "key_vault_alert_availability_enabled" {
  type    = bool
  default = false
}
variable "key_vault_alert_saturation_shoebox_enabled" {
  type    = bool
  default = false
}

variable "ai_search_alert_search_latency_enabled" {
  type    = bool
  default = false
}
variable "ai_search_alert_throttled_pct_enabled" {
  type    = bool
  default = false
}

variable "ai_services_alert_availability_rate_enabled" {
  type    = bool
  default = false
}
variable "ai_services_alert_normalized_ttft_enabled" {
  type    = bool
  default = false
}
variable "ai_services_alert_ttlt_enabled" {
  type    = bool
  default = false
}
variable "ai_services_alert_processed_tokens_enabled" {
  type    = bool
  default = false
}