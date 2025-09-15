module "framework-core" {
  source = "../../../stacks/framework-core"

  # Providers
  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  # Tags
  tags      = var.tags
  tenant_id = var.tenant_id

  # AD Groups (optional)
  ad_read_group_id = var.ad_read_group_id
  ad_full_group_id = var.ad_full_group_id

  # Service Principals (optional)
  sp_app_id  = var.sp_app_id
  sp_cicd_id = var.sp_cicd_id

  # Action Group (optional)
  action_group_emails = var.action_group_emails

  service_prefix = var.service_prefix
  location       = var.location

  # Network (for private endpoints)
  subnet_name              = var.subnet_name
  vnet_name                = var.vnet_name
  dns_resource_group_name  = var.dns_resource_group_name
  vnet_resource_group_name = var.vnet_resource_group_name

  # Observability
  log_analytics_workspace_name                = var.log_analytics_workspace_name
  log_analytics_workspace_resource_group_name = var.log_analytics_workspace_resource_group_name

  # SQL Server (required)
  serial_number                = var.serial_number
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  entra_admin_login_name       = var.entra_admin_login_name
  entra_admin_object_id        = var.entra_admin_object_id

  # SQL Database (required name; other settings optional)
  sql_database_name                        = var.sql_database_name
  sql_database_sku_name                    = var.sql_database_sku_name
  sql_database_min_capacity                = var.sql_database_min_capacity
  sql_database_auto_pause_delay_in_minutes = var.sql_database_auto_pause_delay_in_minutes
  sql_database_zone_redundant              = var.sql_database_zone_redundant
  sql_database_pitr_days                   = var.sql_database_pitr_days
  sql_database_backup_interval_in_hours    = var.sql_database_backup_interval_in_hours
  sql_database_weekly_ltr_weeks            = var.sql_database_weekly_ltr_weeks
  sql_database_monthly_ltr_months          = var.sql_database_monthly_ltr_months
  sql_database_yearly_ltr_years            = var.sql_database_yearly_ltr_years

  # Storage Account settings
  storage_account_account_tier             = var.storage_account_account_tier
  storage_account_account_replication_type = var.storage_account_account_replication_type
  storage_account_account_kind             = var.storage_account_account_kind
  storage_account_access_tier              = var.storage_account_access_tier

  # Key Vault settings
  key_vault_sku_name                   = var.key_vault_sku_name
  key_vault_soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  key_vault_purge_protection_enabled   = var.key_vault_purge_protection_enabled

  # AI Search settings
  ai_search_sku                 = var.ai_search_sku
  ai_search_semantic_search_sku = var.ai_search_semantic_search_sku
  ai_search_replica_count       = var.ai_search_replica_count
  ai_search_partition_count     = var.ai_search_partition_count

  # AI Services settings
  ai_services_sku_name               = var.ai_services_sku_name
  ai_services_model_deployment_names = var.ai_services_model_deployment_names

  # Alert toggles (all default to true)
  sql_db_alert_availability_enabled            = var.sql_db_alert_availability_enabled
  sql_db_alert_app_cpu_percent_enabled         = var.sql_db_alert_app_cpu_percent_enabled
  sql_db_alert_app_memory_percent_enabled      = var.sql_db_alert_app_memory_percent_enabled
  sql_db_alert_instance_cpu_percent_enabled    = var.sql_db_alert_instance_cpu_percent_enabled
  sql_db_alert_instance_memory_percent_enabled = var.sql_db_alert_instance_memory_percent_enabled
  sql_db_alert_storage_percent_enabled         = var.sql_db_alert_storage_percent_enabled

  storage_alert_availability_enabled           = var.storage_alert_availability_enabled
  storage_alert_success_server_latency_enabled = var.storage_alert_success_server_latency_enabled
  storage_alert_used_capacity_enabled          = var.storage_alert_used_capacity_enabled

  key_vault_alert_availability_enabled       = var.key_vault_alert_availability_enabled
  key_vault_alert_saturation_shoebox_enabled = var.key_vault_alert_saturation_shoebox_enabled

  ai_search_alert_search_latency_enabled = var.ai_search_alert_search_latency_enabled
  ai_search_alert_throttled_pct_enabled  = var.ai_search_alert_throttled_pct_enabled

  ai_services_alert_availability_rate_enabled = var.ai_services_alert_availability_rate_enabled
  ai_services_alert_normalized_ttft_enabled   = var.ai_services_alert_normalized_ttft_enabled
  ai_services_alert_ttlt_enabled              = var.ai_services_alert_ttlt_enabled
  ai_services_alert_processed_tokens_enabled  = var.ai_services_alert_processed_tokens_enabled

}


