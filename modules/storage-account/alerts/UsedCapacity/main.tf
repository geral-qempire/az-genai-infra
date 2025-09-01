locals {
  sa_resource_name = try(element(split("/", var.scopes[0]), length(split("/", var.scopes[0])) - 1), "resource")
  default_name     = "alrt-used-${local.sa_resource_name}"
}

resource "azurerm_monitor_metric_alert" "this" {
  name                = coalesce(var.name, local.default_name)
  resource_group_name = var.resource_group_name
  scopes              = var.scopes

  description = coalesce(
    var.description,
    "Alert when Storage Account UsedCapacity (Average) over PT1H is above ${var.threshold} bytes."
  )

  severity      = 3
  enabled       = var.enabled
  auto_mitigate = var.auto_mitigate
  tags          = var.tags

  frequency   = "PT1H"
  window_size = "PT1H"

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "UsedCapacity"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.threshold
  }

  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id = action.value
    }
  }
}


