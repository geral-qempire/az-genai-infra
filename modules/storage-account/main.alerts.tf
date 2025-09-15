########################################
# Alerts - Azure Storage Account
########################################

locals {
  storage_account_resource_name = azurerm_storage_account.this.name

  # Default alert names following the pattern alrt-<metric-abbreviation>-<resource-name>
  default_avail_alert_name = "alrt-avail-${local.storage_account_resource_name}"
  default_sslat_alert_name = "alrt-sslat-${local.storage_account_resource_name}"
  default_used_alert_name  = "alrt-used-${local.storage_account_resource_name}"
}

########################################
# Availability Alert
########################################
resource "azurerm_monitor_metric_alert" "availability" {
  count               = var.enable_availability_alert ? 1 : 0
  name                = coalesce(var.availability_alert_name, local.default_avail_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_storage_account.this.id]

  description = coalesce(
    var.availability_alert_description,
    "Alert when Storage Account availability (Average) over ${var.availability_alert_window_size} is below ${var.availability_alert_threshold}%."
  )

  severity      = var.availability_alert_severity
  enabled       = var.availability_alert_enabled
  auto_mitigate = var.availability_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.availability_alert_frequency
  window_size = var.availability_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Availability"
    aggregation      = var.availability_alert_aggregation
    operator         = var.availability_alert_operator
    threshold        = var.availability_alert_threshold
  }

  dynamic "action" {
    for_each = var.availability_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# Success Server Latency Alert
########################################
resource "azurerm_monitor_metric_alert" "success_server_latency" {
  count               = var.enable_success_server_latency_alert ? 1 : 0
  name                = coalesce(var.success_server_latency_alert_name, local.default_sslat_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_storage_account.this.id]

  description = coalesce(
    var.success_server_latency_alert_description,
    "Alert when Storage Account Success Server Latency (Average) over ${var.success_server_latency_alert_window_size} is above ${var.success_server_latency_alert_threshold}ms."
  )

  severity      = var.success_server_latency_alert_severity
  enabled       = var.success_server_latency_alert_enabled
  auto_mitigate = var.success_server_latency_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.success_server_latency_alert_frequency
  window_size = var.success_server_latency_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "SuccessServerLatency"
    aggregation      = var.success_server_latency_alert_aggregation
    operator         = var.success_server_latency_alert_operator
    threshold        = var.success_server_latency_alert_threshold
  }

  dynamic "action" {
    for_each = var.success_server_latency_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# Used Capacity Alert
########################################
resource "azurerm_monitor_metric_alert" "used_capacity" {
  count               = var.enable_used_capacity_alert ? 1 : 0
  name                = coalesce(var.used_capacity_alert_name, local.default_used_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_storage_account.this.id]

  description = coalesce(
    var.used_capacity_alert_description,
    "Alert when Storage Account UsedCapacity (Average) over ${var.used_capacity_alert_window_size} is above ${var.used_capacity_alert_threshold} bytes."
  )

  severity      = var.used_capacity_alert_severity
  enabled       = var.used_capacity_alert_enabled
  auto_mitigate = var.used_capacity_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.used_capacity_alert_frequency
  window_size = var.used_capacity_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "UsedCapacity"
    aggregation      = var.used_capacity_alert_aggregation
    operator         = var.used_capacity_alert_operator
    threshold        = var.used_capacity_alert_threshold
  }

  dynamic "action" {
    for_each = var.used_capacity_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}
