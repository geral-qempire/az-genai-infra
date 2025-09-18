module "simple_usecase" {
  source = "../../../stacks/usecase-proj-ais-st-sql"

  # Providers
  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  # Tags
  tags = var.tags

  tenant_id = var.tenant_id

  service_prefix = var.service_prefix
  location       = var.location
  environment    = var.environment

  # Network (for private endpoints)
  subnet_name              = var.subnet_name
  vnet_name                = var.vnet_name
  dns_resource_group_name  = var.dns_resource_group_name
  vnet_resource_group_name = var.vnet_resource_group_name

  # AD Groups
  ad_read_group_id = var.ad_read_group_id
  ad_full_group_id = var.ad_full_group_id

  # Service Principals
  sp_app_id  = var.sp_app_id
  sp_cicd_id = var.sp_cicd_id

  # Framework core (existing)
  framework_resource_group_name  = var.framework_resource_group_name
  framework_hub_name             = var.framework_hub_name
  framework_storage_account_name = var.framework_storage_account_name
  framework_ai_search_name       = var.framework_ai_search_name

  # AI Services
  ai_services_sku_name               = var.ai_services_sku_name
  ai_services_model_deployment_names = var.ai_services_model_deployment_names

  # SQL (required)
  serial_number                = var.serial_number
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  entra_admin_login_name       = var.entra_admin_login_name
  entra_admin_object_id        = var.entra_admin_object_id
  sql_database_name            = var.sql_database_name

  sql_database_sku_name                    = var.sql_database_sku_name
  sql_database_min_capacity                = var.sql_database_min_capacity
  sql_database_zone_redundant              = var.sql_database_zone_redundant
  sql_database_auto_pause_delay_in_minutes = var.sql_database_auto_pause_delay_in_minutes
  sql_database_backup_interval_in_hours    = var.sql_database_backup_interval_in_hours
  sql_database_weekly_ltr_weeks            = var.sql_database_weekly_ltr_weeks
  sql_database_monthly_ltr_months          = var.sql_database_monthly_ltr_months
  sql_database_yearly_ltr_years            = var.sql_database_yearly_ltr_years

  # Alerts (default false)
  ai_services_alert_availability_rate_enabled = var.ai_services_alert_availability_rate_enabled
  ai_services_alert_normalized_ttft_enabled   = var.ai_services_alert_normalized_ttft_enabled
  ai_services_alert_ttlt_enabled              = var.ai_services_alert_ttlt_enabled
  ai_services_alert_processed_tokens_enabled  = var.ai_services_alert_processed_tokens_enabled

  # Action Group (optional)
  action_group_emails = var.action_group_emails
}

