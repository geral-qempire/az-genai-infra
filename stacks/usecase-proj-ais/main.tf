/**
 * Simple Use Case Template
 * - AI Services (Private Endpoint + System Assigned Identity)
 * - AI Project (System Assigned Identity) + AI Services connection
 */

########################################
# Abbreviations
########################################
module "region_abbreviations" {
  source = "../../modules/region-abbreviations"
}

########################################
# Resource Group
########################################
resource "azurerm_resource_group" "this" {
  name     = "rg-${module.region_abbreviations.regions[var.location]}-${var.service_prefix}"
  location = var.location
  tags     = var.tags
}

########################################
# Lookups (Framework, Network, Observability)
########################################
data "azurerm_resource_group" "framework" {
  name = var.framework_resource_group_name
}

data "azurerm_machine_learning_workspace" "framework_hub" {
  name                = var.framework_hub_name
  resource_group_name = data.azurerm_resource_group.framework.name
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
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions

  enabled = var.action_group_enabled

  email_receivers = local.action_group_receivers

  tags = var.tags
}

########################################
# AI Services (PE + Identity)
########################################
module "ai_services" {
  source = "../../modules/ai-services"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  sku_name                     = var.ai_services_sku_name
  local_authentication_enabled = true
  public_network_access        = "Enabled"
  network_acls_bypass          = "AzureServices"

  identity = {
    type = "SystemAssigned"
  }

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  # Alerts
  enable_availability_rate_alert = var.ai_services_alert_availability_rate_enabled
  enable_processed_tokens_alert  = var.ai_services_alert_processed_tokens_enabled
  enable_ttft_alert              = var.ai_services_alert_normalized_ttft_enabled
  enable_ttlt_alert              = var.ai_services_alert_ttlt_enabled

  # Action groups for alerts
  availability_rate_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  processed_tokens_alert_action_group_ids  = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  ttft_alert_action_group_ids              = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  ttlt_alert_action_group_ids              = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])

  tags = var.tags
}


########################################
# AI Project (Identity)
########################################
module "ai_project" {
  source = "../../modules/ai-project"

  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  hub_id = data.azurerm_machine_learning_workspace.framework_hub.id

  identity = {
    type = "SystemAssigned"
  }

  tags = var.tags
}

########################################
# Connections (AI Services -> Project)
########################################
module "ai_services_connection" {
  source = "../../modules/ai-services-hub-connection"

  parent_id          = module.ai_project.ai_project_id
  ai_services_module = module.ai_services

  depends_on = [module.ai_project, module.ai_services]
}


