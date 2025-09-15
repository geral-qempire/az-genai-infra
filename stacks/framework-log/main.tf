/**
 * Framework Log Template
 * - Creates a foundational Resource Group
 * - Provisions Log Analytics Workspace with configurable settings
 * - Optional RBAC for AD Groups (read/full access)
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
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  sku               = var.law_sku
  retention_in_days = var.law_retention_in_days
  daily_quota_gb    = var.law_daily_quota_gb

  tags = var.tags
}


