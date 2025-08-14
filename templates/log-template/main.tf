locals {
  common_tags = merge({
    environment = var.environment
    project     = var.service_prefix
  }, var.tags)
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${module.region_abbreviations.regions[var.location]}-${var.service_prefix}"
  location = var.location
  tags     = local.common_tags
}

module "region_abbreviations" {
  source = "../../modules/region-abbreviations"
}

module "log_analytics_workspace" {
  source = "../../modules/log-analytics-workspace/resource"

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  sku               = var.law_sku
  retention_in_days = var.law_retention_in_days
  daily_quota_gb    = var.law_daily_quota_gb

  tags = local.common_tags
}

 

