module "ai_project" {
  source = "../../../stacks/ai-project"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  # Tags
  tags = var.tags

  # Core
  environment    = var.environment
  service_prefix = var.service_prefix
  location       = var.location

  # Existing AI Hub
  hub_resource_group_name = var.hub_resource_group_name
  hub_name                = var.hub_name

  # AI Project
  ai_project_location = var.ai_project_location
  friendly_name       = var.friendly_name

  # AI Services location override
  ai_services_location = var.ai_services_location

  # AD Groups (optional)
  ad_read_group_id = var.ad_read_group_id
  ad_full_group_id = var.ad_full_group_id

  # Service Principals (optional)
  sp_app_id  = var.sp_app_id
  sp_cicd_id = var.sp_cicd_id

  # Network (for private endpoints)
  subnet_name              = var.subnet_name
  vnet_name                = var.vnet_name
  dns_resource_group_name  = var.dns_resource_group_name
  vnet_resource_group_name = var.vnet_resource_group_name

  # AI Services
  ai_services_sku_name               = var.ai_services_sku_name
  ai_services_model_deployment_names = var.ai_services_model_deployment_names

  # AI Services Alerts
  ai_services_alert_availability_rate_enabled = var.ai_services_alert_availability_rate_enabled
  ai_services_alert_normalized_ttft_enabled   = var.ai_services_alert_normalized_ttft_enabled
  ai_services_alert_ttlt_enabled              = var.ai_services_alert_ttlt_enabled
  ai_services_alert_processed_tokens_enabled  = var.ai_services_alert_processed_tokens_enabled

  # Action Group (optional)
  action_group_id     = var.action_group_id
  action_group_emails = var.action_group_emails
}
