/**
 * AI Project Stack
 * - AI Project (azapi_resource in separate RG from hub)
 * - AI Services (Private Endpoint + System Assigned Identity)
 * - AI Services connection to the Project
 * - Hub PE outbound rule for AI Services
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
# Lookups (Hub, Network)
########################################
data "azurerm_resource_group" "hub" {
  name = var.hub_resource_group_name
}

data "azurerm_machine_learning_workspace" "hub" {
  name                = var.hub_name
  resource_group_name = data.azurerm_resource_group.hub.name
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
  ai_project_location  = coalesce(var.ai_project_location, var.location)
  ai_services_location = coalesce(var.ai_services_location, var.location)

  region_abbreviation = module.region_abbreviations.regions[var.location]
  project_name        = lower("proj-${module.region_abbreviations.regions[local.ai_project_location]}-${var.service_prefix}-${var.environment}")

  action_group_receivers = length(var.action_group_email_receivers) > 0 ? var.action_group_email_receivers : {
    for idx, addr in var.action_group_emails : format("email%02d", idx + 1) => { email_address = addr }
  }

  resolved_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
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
# AI Project (azapi – separate RG from hub)
########################################
resource "azapi_resource" "ai_project" {
  type                      = "Microsoft.MachineLearningServices/workspaces@2024-10-01"
  name                      = local.project_name
  parent_id                 = azurerm_resource_group.this.id
  location                  = local.ai_project_location
  schema_validation_enabled = false

  identity {
    type = "SystemAssigned"
  }

  body = {
    kind = "Project"
    properties = {
      friendlyName  = var.friendly_name != "" ? var.friendly_name : null
      hubResourceId = data.azurerm_machine_learning_workspace.hub.id
    }
  }

  tags = var.tags
}

########################################
# AI Services (PE + Identity + Alerts)
########################################
module "ai_services" {
  source = "../../modules/ai-services"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = local.ai_services_location
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
  private_endpoint_location = local.ai_services_location

  # Alerts
  enable_availability_rate_alert = var.ai_services_alert_availability_rate_enabled
  enable_processed_tokens_alert  = var.ai_services_alert_processed_tokens_enabled
  enable_ttft_alert              = var.ai_services_alert_normalized_ttft_enabled
  enable_ttlt_alert              = var.ai_services_alert_ttlt_enabled

  availability_rate_alert_action_group_ids = local.resolved_action_group_ids
  processed_tokens_alert_action_group_ids  = local.resolved_action_group_ids
  ttft_alert_action_group_ids              = local.resolved_action_group_ids
  ttlt_alert_action_group_ids              = local.resolved_action_group_ids

  tags = var.tags
}

########################################
# Hub Outbound Rule (PE → AI Services)
########################################
module "hub_pep_outbound_rule_ai_services" {
  source = "../../modules/ai-hub-pep-outbound-rule"

  parent_id           = data.azurerm_machine_learning_workspace.hub.id
  service_resource_id = module.ai_services.ai_services_id
  sub_resource_target = "account"

  spark_enabled = false

  depends_on = [module.ai_services]
}

########################################
# Connections (AI Services → Project)
########################################
module "ai_services_connection" {
  source = "../../modules/ai-services-hub-connection"

  parent_id          = azapi_resource.ai_project.id
  ai_services_module = module.ai_services

  depends_on = [azapi_resource.ai_project, module.ai_services, module.hub_pep_outbound_rule_ai_services]
}
