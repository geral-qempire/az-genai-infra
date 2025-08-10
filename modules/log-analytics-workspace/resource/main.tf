resource "azurerm_log_analytics_workspace" "this" {
  name                = lower("log-${lookup(var.region_abbreviations, var.location, "")}-${var.service_prefix}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = var.sku
  retention_in_days = var.retention_in_days
  daily_quota_gb    = var.daily_quota_gb

  tags = var.tags
}


