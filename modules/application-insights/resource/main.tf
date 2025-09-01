locals {
  region_abbreviation = lookup(var.region_abbreviations, var.location, "")
  application_name    = lower("appi-${local.region_abbreviation}-${var.service_prefix}-${var.environment}")
}

resource "azurerm_application_insights" "this" {
  name                = local.application_name
  location            = var.location
  resource_group_name = var.resource_group_name

  application_type = var.application_type

  workspace_id = var.workspace_id != "" ? var.workspace_id : null

  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled

  tags = var.tags
  lifecycle {
    ignore_changes = [
      internet_ingestion_enabled,
      internet_query_enabled,
    ]
  }
}


