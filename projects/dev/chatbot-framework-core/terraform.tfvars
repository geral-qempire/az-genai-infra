# Subscription IDs
infra_subscription_id = "cb084404-ffbb-4bca-8a99-272625f6008a"
dns_subscription_id   = "cb084404-ffbb-4bca-8a99-272625f6008a"
tenant_id             = "76711bfe-abaa-4c8c-814a-aa3a2b68ad92"

# Core
service_prefix = "frame-core"
location       = "swedencentral"
environment    = "dev"

# Tags
tags = {
  environment     = "DEV"
  useCase         = "CHATBOT-COMMON"
  costCenter      = "41000 - DDA"
  businessUnit    = "41400 - DDA-DATA SCIENCE"
  applicationName = "MAAIF"
  applicationCode = "CA1148"
}

# AD Groups
ad_read_group_id = "188bbe45-d58e-4f42-a97c-f46cec30ba6d"
ad_full_group_id = "059bb0a1-d2f1-49e9-a5c8-d0cf66ec55ac"

# Service Principals
sp_app_id  = "1307ca49-6a7f-4d2a-8642-e4042ae46a65"
sp_cicd_id = "3ff06dab-8286-4d33-80a4-4ad3495b7d726"

# Network (for private endpoints)
subnet_name              = "snet-dev"
vnet_name                = "vnet-sdc-genai-networking"
vnet_resource_group_name = "rg-sdc-genai-networking"
dns_resource_group_name  = "rg-sdc-dns"

# Observability
log_analytics_workspace_name                = "log-sdc-genai-log-dev"
log_analytics_workspace_resource_group_name = "rg-sdc-genai-log"

# SQL Server
serial_number                = "0002"
administrator_login          = "sqldbadmin"
administrator_login_password = "Password123!"
entra_admin_object_id        = "035f0181-53de-4884-9e2e-e7ae13a4b4a1"
entra_admin_login_name       = "SQL ADMIN"

# SQL Database
sql_database_name                        = "chatbot-db"
sql_database_sku_name                    = "GP_S_Gen5_2"
sql_database_min_capacity                = 0.5
sql_database_zone_redundant              = false
sql_database_auto_pause_delay_in_minutes = 15
sql_database_backup_interval_in_hours    = 0
sql_database_weekly_ltr_weeks            = 0
sql_database_monthly_ltr_months          = 0
sql_database_yearly_ltr_years            = 0

# Storage Account
storage_account_account_tier             = "Standard"
storage_account_account_replication_type = "LRS"
storage_account_account_kind             = "StorageV2"
storage_account_access_tier              = "Hot"

# Key Vault
key_vault_sku_name                   = "standard"
key_vault_soft_delete_retention_days = 90
key_vault_purge_protection_enabled   = true

# AI Search
ai_search_sku                 = "basic"
ai_search_semantic_search_sku = "free"
ai_search_replica_count       = 1
ai_search_partition_count     = 1

# AI Services
ai_services_sku_name               = "S0"
ai_services_model_deployment_names = []

# Action Group
action_group_emails = ["diogoazevedo15@gmail.com"]

# Alert toggles (all enabled by default)
sql_db_alert_availability_enabled            = true
sql_db_alert_app_cpu_percent_enabled         = true
sql_db_alert_app_memory_percent_enabled      = true
sql_db_alert_instance_cpu_percent_enabled    = false # Non-serverless only
sql_db_alert_instance_memory_percent_enabled = false # Non-serverless only
sql_db_alert_storage_percent_enabled         = true
storage_alert_availability_enabled           = true
storage_alert_success_server_latency_enabled = true
storage_alert_used_capacity_enabled          = true
key_vault_alert_availability_enabled         = true
key_vault_alert_saturation_shoebox_enabled   = true
ai_search_alert_search_latency_enabled       = true
ai_search_alert_throttled_pct_enabled        = true
ai_services_alert_availability_rate_enabled  = true
ai_services_alert_normalized_ttft_enabled    = true
ai_services_alert_ttlt_enabled               = true
ai_services_alert_processed_tokens_enabled   = true

fqdn_rules = [
  "*.vscode.dev",
  "*.vscode-unpkg.net",
  "*.vscode-cdn.net",
  "*.vscodeexperiments.azureedge.net",
  "default.exp-tas.com",
  "code.visualstudio.com",
  "update.code.visualstudio.com",
  "*.vo.msecnd.net",
]