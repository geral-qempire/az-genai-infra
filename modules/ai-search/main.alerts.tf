########################################
# Alerts - Azure AI Search
########################################

locals {
  search_resource_name       = azurerm_search_service.this.name
  default_latency_alert_name = "alrt-lat-${local.search_resource_name}"
  default_thrpct_alert_name  = "alrt-thrpct-${local.search_resource_name}"
}

########################################
# Search Latency Alert
########################################
resource "azurerm_monitor_metric_alert" "latency" {
  count               = var.enable_search_latency_alert ? 1 : 0
  name                = coalesce(var.search_latency_alert_name, local.default_latency_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_search_service.this.id]

  description = coalesce(
    var.search_latency_alert_description,
    "Alert when SearchLatency (Average) over ${var.search_latency_alert_window_size} is above ${var.search_latency_alert_threshold}ms."
  )

  severity      = var.search_latency_alert_severity
  enabled       = var.search_latency_alert_enabled
  auto_mitigate = var.search_latency_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.search_latency_alert_frequency
  window_size = var.search_latency_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Search/searchServices"
    metric_name      = "SearchLatency"
    aggregation      = var.search_latency_alert_aggregation
    operator         = var.search_latency_alert_operator
    threshold        = var.search_latency_alert_threshold
  }

  dynamic "action" {
    for_each = var.search_latency_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# Throttled Search Queries Percentage Alert
########################################
resource "azurerm_monitor_metric_alert" "throttled_pct" {
  count               = var.enable_throttled_search_pct_alert ? 1 : 0
  name                = coalesce(var.throttled_search_pct_alert_name, local.default_thrpct_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_search_service.this.id]

  description = coalesce(
    var.throttled_search_pct_alert_description,
    "Alert when ThrottledSearchQueriesPercentage (Average) over ${var.throttled_search_pct_alert_window_size} is above ${var.throttled_search_pct_alert_threshold}%."
  )

  severity      = var.throttled_search_pct_alert_severity
  enabled       = var.throttled_search_pct_alert_enabled
  auto_mitigate = var.throttled_search_pct_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.throttled_search_pct_alert_frequency
  window_size = var.throttled_search_pct_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Search/searchServices"
    metric_name      = "ThrottledSearchQueriesPercentage"
    aggregation      = var.throttled_search_pct_alert_aggregation
    operator         = var.throttled_search_pct_alert_operator
    threshold        = var.throttled_search_pct_alert_threshold
  }

  dynamic "action" {
    for_each = var.throttled_search_pct_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}


