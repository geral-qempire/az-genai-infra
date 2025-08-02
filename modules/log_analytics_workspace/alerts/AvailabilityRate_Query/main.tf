# Azure Monitor Metric Alert for Log Analytics workspace availability (user query success rate)
resource "azurerm_monitor_metric_alert" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes

  # Default to an informative description if none was supplied
  description = coalesce(
    var.description,
    "Alert when AvailabilityRate_Query (Average) over PT1H is below ${var.threshold}%."
  )

  # Required by your enterprise policy
  severity = 1
  enabled  = var.enabled

  # ISO8601 durations
  frequency   = "PT5M"
  window_size = "PT1H"

  # Condition: Average availability rate is less than threshold
  criteria {
    metric_namespace = "Microsoft.OperationalInsights/workspaces"
    metric_name      = "AvailabilityRate_Query"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = var.threshold

    # Dimension note:
    # This metric exposes a dimension "IsUserQuery". Omitting dimensions evaluates at the workspace level,
    # which matches the "user query success rate for this workspace" SLI.
    # If you need to filter by dimension (e.g., IsUserQuery == "true"), add a dimension block here.
  }

  # Optional: bind one or more Action Groups
  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id = action.value
    }
  }
}
