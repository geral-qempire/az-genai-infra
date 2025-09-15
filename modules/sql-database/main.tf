locals {
  database_name = var.name
}

resource "azurerm_mssql_database" "this" {
  name                        = local.database_name
  server_id                   = var.server_id
  sku_name                    = var.sku_name
  min_capacity                = var.min_capacity
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  collation                   = var.collation
  zone_redundant              = var.zone_redundant
  tags                        = var.tags

  short_term_retention_policy {
    retention_days           = var.pitr_days
    backup_interval_in_hours = var.backup_interval_in_hours > 0 ? var.backup_interval_in_hours : null
  }

  dynamic "long_term_retention_policy" {
    for_each = (var.weekly_ltr_weeks > 0 || var.monthly_ltr_months > 0 || var.yearly_ltr_years > 0) ? [1] : []
    content {
      weekly_retention  = var.weekly_ltr_weeks > 0 ? "P${var.weekly_ltr_weeks}W" : null
      monthly_retention = var.monthly_ltr_months > 0 ? "P${var.monthly_ltr_months}M" : null
      yearly_retention  = var.yearly_ltr_years > 0 ? "P${var.yearly_ltr_years}Y" : null
      # Set a default week_of_year only when yearly retention is configured
      week_of_year = var.yearly_ltr_years > 0 ? 1 : null
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}

