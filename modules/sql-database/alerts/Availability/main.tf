locals {
  sql_db_resource_name = try(element(split("/", var.scopes[0]), length(split("/", var.scopes[0])) - 1), "resource")
  default_name         = "alrt-avail-${local.sql_db_resource_name}"
}

resource "azurerm_monitor_metric_alert" "this" {
  name                = coalesce(var.name, local.default_name)
  resource_group_name = var.resource_group_name
  scopes              = var.scopes

  description = coalesce(
    var.description,
    "Alert when SQL Database Availability (Average) over PT5M is below ${var.threshold}%."
  )

  severity      = 1
  enabled       = var.enabled
  auto_mitigate = var.auto_mitigate
  tags          = var.tags

  frequency   = "PT1M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = var.threshold
  }

  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id = action.value
    }
  }
}


