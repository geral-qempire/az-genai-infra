/**
 * Storage Account Tiers Template
 * - Deploys Storage Account with pre-configured tier settings
 * - Configures RBAC profiles for tech leads and developers
 * - Enables private endpoints and default alerts
 */

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
# Storage Account
########################################
module "storage_account" {
  source = "../../modules/storage-account"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = var.resource_group_name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  account_tier                      = local.selected_tier.account_tier
  account_replication_type          = local.selected_tier.account_replication_type
  account_kind                      = local.selected_tier.account_kind
  access_tier                       = local.selected_tier.access_tier
  min_tls_version                   = local.selected_tier.min_tls_version
  public_network_access_enabled     = local.selected_tier.public_network_access_enabled
  shared_access_key_enabled         = local.selected_tier.shared_access_key_enabled
  infrastructure_encryption_enabled = local.selected_tier.infrastructure_encryption_enabled
  network_rules_default_action      = local.selected_tier.network_rules_default_action
  network_rules_bypass              = local.selected_tier.network_rules_bypass

  # Private Endpoints (configurable per deployment)
  enable_private_endpoint_blob  = var.enable_private_endpoint_blob
  enable_private_endpoint_file  = var.enable_private_endpoint_file
  enable_private_endpoint_table = var.enable_private_endpoint_table
  enable_private_endpoint_queue = var.enable_private_endpoint_queue

  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  # Integrated Alerts
  enable_availability_alert           = local.selected_tier.enable_availability_alert
  enable_success_server_latency_alert = local.selected_tier.enable_success_server_latency_alert
  enable_used_capacity_alert         = local.selected_tier.enable_used_capacity_alert

  # Alert Configuration
  availability_alert_action_group_ids           = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  success_server_latency_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  used_capacity_alert_action_group_ids         = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])

  tags = var.tags
}

########################################
# Storage Account Additional Configuration
# Note: blob_properties, file_properties (soft delete retention), and is_sftp_enabled
# are not currently exposed by the storage-account module. These may need to be
# configured via Azure Portal, CLI, or module extension in the future.
########################################
