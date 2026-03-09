/**
 * Key Vault Tiers Template
 * - Deploys Key Vault with pre-configured tier settings
 * - Configures RBAC profiles for tech leads and developers
 * - Enables private endpoint and default alerts
 */

data "azurerm_client_config" "current" {}

########################################
# Abbreviations
########################################
module "region_abbreviations" {
  source = "../../modules/region-abbreviations"
}

########################################
# Lookups (Resource Group and Subnet for Private Endpoint)
########################################
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_subnet" "private_endpoints" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

########################################
# Action Group (Optional)
########################################
locals {
  action_group_receivers = length(var.action_group_email_receivers) > 0 ? var.action_group_email_receivers : {
    for idx, addr in var.action_group_emails : format("email%02d", idx + 1) => { email_address = addr }
  }
}

module "action_group" {
  count  = length(local.action_group_receivers) > 0 ? 1 : 0
  source = "../../modules/action-group-map"

  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = var.resource_group_name
  region_abbreviations = module.region_abbreviations.regions

  enabled = var.action_group_enabled

  email_receivers = local.action_group_receivers

  tags = var.tags
}

########################################
# Key Vault
########################################
module "key_vault" {
  source = "../../modules/key-vault"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = var.resource_group_name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  tenant_id                       = var.tenant_id
  sku_name                        = local.selected_tier.sku_name
  soft_delete_retention_days      = local.selected_tier.soft_delete_retention_days
  purge_protection_enabled        = local.selected_tier.purge_protection_enabled
  public_network_access_enabled  = local.selected_tier.public_network_access_enabled
  enable_rbac_authorization      = local.selected_tier.enable_rbac_authorization
  network_acls_bypass            = local.selected_tier.network_acls_bypass
  enabled_for_deployment         = local.selected_tier.enabled_for_deployment
  enabled_for_disk_encryption    = local.selected_tier.enabled_for_disk_encryption
  enabled_for_template_deployment = local.selected_tier.enabled_for_template_deployment

  # Private Endpoint
  enable_private_endpoint   = local.selected_tier.enable_private_endpoint
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  # Integrated Alerts
  enable_availability_alert = local.selected_tier.enable_availability_alert
  enable_saturation_alert   = local.selected_tier.enable_saturation_alert

  # Alert Configuration
  availability_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  saturation_alert_action_group_ids   = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])

  tags = var.tags
}

