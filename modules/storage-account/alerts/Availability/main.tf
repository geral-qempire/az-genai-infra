locals {
  sa_resource_name = try(element(split("/", var.scopes[0]), length(split("/", var.scopes[0])) - 1), "resource")
  default_name     = "alrt-avail-${local.sa_resource_name}"
}

resource "azurerm_monitor_metric_alert" "this" {
  name                = coalesce(var.name, local.default_name)
  resource_group_name = var.resource_group_name
  scopes              = var.scopes

  description = coalesce(
    var.description,
    "Alert when Storage Account Availability (Average) over PT1M is below ${var.threshold}%."
  )

  severity      = 1
  enabled       = var.enabled
  auto_mitigate = var.auto_mitigate
  tags          = var.tags

  frequency   = "PT1M"
  window_size = "PT1M"

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Availability"
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


