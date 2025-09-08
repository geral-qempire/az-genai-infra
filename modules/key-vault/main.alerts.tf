########################################
# Alerts - Azure Key Vault
########################################

locals {
  key_vault_resource_name = azurerm_key_vault.this.name
  default_avail_alert_name = "alrt-avail-${local.key_vault_resource_name}"
  default_sat_alert_name   = "alrt-sat-${local.key_vault_resource_name}"
}

########################################
# Key Vault Availability Alert
########################################
resource "azurerm_monitor_metric_alert" "availability" {
  count               = var.enable_availability_alert ? 1 : 0
  name                = coalesce(var.availability_alert_name, local.default_avail_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_key_vault.this.id]

  description = coalesce(
    var.availability_alert_description,
    "Alert when Key Vault Availability (Average) over ${var.availability_alert_window_size} is below ${var.availability_alert_threshold}%."
  )

  severity      = var.availability_alert_severity
  enabled       = var.availability_alert_enabled
  auto_mitigate = var.availability_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.availability_alert_frequency
  window_size = var.availability_alert_window_size

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
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
# Key Vault Saturation (Capacity Used) Alert
########################################
resource "azurerm_monitor_metric_alert" "saturation" {
  count               = var.enable_saturation_alert ? 1 : 0
  name                = coalesce(var.saturation_alert_name, local.default_sat_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_key_vault.this.id]

  description = coalesce(
    var.saturation_alert_description,
    "Alert when Key Vault SaturationShoebox (Average) over ${var.saturation_alert_window_size} is above ${var.saturation_alert_threshold}%."
  )

  severity      = var.saturation_alert_severity
  enabled       = var.saturation_alert_enabled
  auto_mitigate = var.saturation_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.saturation_alert_frequency
  window_size = var.saturation_alert_window_size

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "SaturationShoebox"
    aggregation      = var.saturation_alert_aggregation
    operator         = var.saturation_alert_operator
    threshold        = var.saturation_alert_threshold
  }

  dynamic "action" {
    for_each = var.saturation_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}
