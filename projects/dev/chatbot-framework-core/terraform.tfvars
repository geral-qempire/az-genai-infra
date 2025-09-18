# Subscription IDs
infra_subscription_id = "2a4f4e29-3789-4e47-867d-62a6eb17950b"
dns_subscription_id   = "0d2447a1-c993-432b-be88-01ba39e66f84"
tenant_id             = "0e20503f-b4f9-44ce-9d36-e5be1a78af16"

# Core
service_prefix = "frame-core"
location       = "swedencentral"
environment    = "shared"

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
# ad_read_group_id = "bcf79a5f-d4fd-4b6f-ba28-57e050690cc9"
ad_full_group_id = "2a9ee019-37d4-474c-a138-565b2a7c2bb6"

# Service Principals
sp_app_id  = "84f7041e-f33e-4217-84ae-810dac40fa70"
sp_cicd_id = "24e609e8-840e-475c-ac8b-c6e4c074d870"

# Network (for private endpoints)
subnet_name              = "snet-dev"
vnet_name                = "vnet-sdc-genai"
vnet_resource_group_name = "rg-sdc-genai-networking"
dns_resource_group_name  = "rg-swc-dns"

# Observability
log_analytics_workspace_name                = "log-sdc-genai-log-dev"
log_analytics_workspace_resource_group_name = "rg-sdc-genai-log"

# SQL Server
serial_number                = "0001"
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
sql_database_backup_interval_in_hours    = 12
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