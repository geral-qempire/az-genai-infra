locals {
  region_abbreviation = lookup(var.region_abbreviations, var.location, false)
  action_group_name   = "ag-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  action_group_short_name = substr(replace(local.action_group_name, "-", ""), 0, 12)
}

resource "azurerm_monitor_action_group" "this" {
  name                = local.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = local.action_group_short_name
  enabled             = var.enabled

  dynamic "email_receiver" {
    for_each = var.email_receivers
    content {
      name                    = email_receiver.key
      email_address          = email_receiver.value.email_address
      use_common_alert_schema = true
    }
  }

  tags = var.tags
}
