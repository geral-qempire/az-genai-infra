locals {
  region_abbreviation = lookup(var.region_abbreviations, var.location, "")
  workspace_name      = lower("log-${local.region_abbreviation}-${var.service_prefix}-${var.environment}")
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = local.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku               = var.sku
  retention_in_days = var.retention_in_days
  daily_quota_gb    = var.daily_quota_gb

  tags = var.tags
}


