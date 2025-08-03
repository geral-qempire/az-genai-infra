resource "azurerm_monitor_metric_alert" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes

  description = coalesce(
    var.description,
    "Alert when Key Vault ServiceApiLatency (Average) over PT5M is above ${var.threshold}ms."
  )

  severity = 1
  enabled  = var.enabled

  frequency   = "PT1M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "ServiceApiLatency"
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