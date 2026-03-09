/**
 * Log Analytics Stack
 *
 * Creates a resource group and a Log Analytics Workspace.
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
# Log Analytics Workspace
########################################
module "log_analytics_workspace" {
  source = "../../modules/log-analytics-workspace"

  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions

  sku               = var.sku
  retention_in_days = var.retention_in_days
  daily_quota_gb    = var.daily_quota_gb

  tags = var.tags
}
