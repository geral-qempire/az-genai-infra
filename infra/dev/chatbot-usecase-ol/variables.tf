# Subscriptions
variable "infra_subscription_id" { type = string }
variable "dns_subscription_id" { type = string }

# Tags
variable "tags" { type = map(string) }

# Setup
variable "service_prefix" { type = string }
variable "location" { type = string }
variable "environment" { type = string }

variable "tenant_id" { type = string }

# Framework core (existing)
variable "framework_resource_group_name" { type = string }
variable "framework_hub_name" { type = string }
variable "framework_storage_account_name" { type = string }
variable "framework_ai_search_name" { type = string }

# Action Group (optional)
variable "action_group_emails" {
  type    = list(string)
  default = []
}

# Network
variable "subnet_name" { type = string }
variable "vnet_name" { type = string }
variable "dns_resource_group_name" { type = string }
variable "vnet_resource_group_name" { type = string }

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

# Framework core (existing)
variable "framework_resource_group_name" { type = string }
variable "framework_hub_name" { type = string }
variable "framework_storage_account_name" { type = string }
variable "framework_ai_search_name" { type = string }

# AI Services
variable "ai_services_sku_name" {
  type    = string
  default = "S0"
}
variable "ai_services_model_deployment_names" {
  type    = list(string)
  default = []
}

# SQL (required by st-sql)
variable "serial_number" { type = string }
variable "administrator_login" { type = string }
variable "administrator_login_password" { type = string }
variable "entra_admin_object_id" { type = string }
variable "entra_admin_login_name" {
  type    = string
  default = ""
}
variable "sql_database_name" { type = string }

# SQL Database optional settings
variable "sql_database_sku_name" {
  type    = string
  default = "S0"
}
variable "sql_database_min_capacity" {
  type    = number
  default = null
}
variable "sql_database_zone_redundant" {
  type    = bool
  default = false
}
variable "sql_database_auto_pause_delay_in_minutes" {
  type    = number
  default = null
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

# Alerts (default false)
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
