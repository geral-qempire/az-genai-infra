module "simple_usecase" {
  source = "../../../stacks/usecase-proj-ais"

  # Providers
  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  # Tags
  tags = var.tags

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

  # Alerts (default false)
  ai_services_alert_availability_rate_enabled = var.ai_services_alert_availability_rate_enabled
  ai_services_alert_normalized_ttft_enabled   = var.ai_services_alert_normalized_ttft_enabled
  ai_services_alert_ttlt_enabled              = var.ai_services_alert_ttlt_enabled
  ai_services_alert_processed_tokens_enabled  = var.ai_services_alert_processed_tokens_enabled

  # Action Group (optional)
  action_group_emails = var.action_group_emails

}