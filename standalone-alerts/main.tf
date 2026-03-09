/**
 * Standalone Azure Alerts Module
 * Creates metric alerts for various Azure resources based on their IDs
 * 
 * Note: This module expects the resource group and action group to already exist.
 * It will load them using data sources and create alerts for the provided resource IDs.
 */

########################################
# Resource Group (Data Source)
########################################
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

########################################
# Action Group (Data Source)
########################################
data "azurerm_monitor_action_group" "this" {
  name                = var.action_group_name
  resource_group_name = data.azurerm_resource_group.this.name
}

########################################
# Local Values
########################################
locals {
  # Default action group ID to use (from data source or variable override)
  default_action_group_id = var.action_group_id != null ? var.action_group_id : data.azurerm_monitor_action_group.this.id
}

########################################
# SQL Database Alerts
########################################

# Availability Alert
resource "azurerm_monitor_metric_alert" "sql_db_availability" {
  for_each = var.sql_database_ids

  name                = "alrt-avail-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when SQL Database availability (Average) over ${var.sql_db_availability_window_size} is below ${var.sql_db_availability_threshold}%."

  severity      = var.sql_db_availability_severity
  enabled       = var.sql_db_availability_enabled
  auto_mitigate = var.sql_db_availability_auto_mitigate
  tags          = var.tags

  frequency   = var.sql_db_availability_frequency
  window_size = var.sql_db_availability_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "availability"
    aggregation      = var.sql_db_availability_aggregation
    operator         = var.sql_db_availability_operator
    threshold        = var.sql_db_availability_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.sql_db_availability_action_group_ids) > 0 ? var.sql_db_availability_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# Storage Percent Alert
resource "azurerm_monitor_metric_alert" "sql_db_storage" {
  for_each = var.sql_database_ids

  name                = "alrt-stor-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when SQL Database storage_percent (Average) over ${var.sql_db_storage_window_size} is above ${var.sql_db_storage_threshold}%."

  severity      = var.sql_db_storage_severity
  enabled       = var.sql_db_storage_enabled
  auto_mitigate = var.sql_db_storage_auto_mitigate
  tags          = var.tags

  frequency   = var.sql_db_storage_frequency
  window_size = var.sql_db_storage_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "storage_percent"
    aggregation      = var.sql_db_storage_aggregation
    operator         = var.sql_db_storage_operator
    threshold        = var.sql_db_storage_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.sql_db_storage_action_group_ids) > 0 ? var.sql_db_storage_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# App CPU Percent Alert (Serverless)
resource "azurerm_monitor_metric_alert" "sql_db_app_cpu" {
  for_each = var.sql_database_serverless_ids

  name                = "alrt-cpu-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when SQL Database app_cpu_percent (Average) over ${var.sql_db_app_cpu_window_size} is above ${var.sql_db_app_cpu_threshold}%."

  severity      = var.sql_db_app_cpu_severity
  enabled       = var.sql_db_app_cpu_enabled
  auto_mitigate = var.sql_db_app_cpu_auto_mitigate
  tags          = var.tags

  frequency   = var.sql_db_app_cpu_frequency
  window_size = var.sql_db_app_cpu_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "app_cpu_percent"
    aggregation      = var.sql_db_app_cpu_aggregation
    operator         = var.sql_db_app_cpu_operator
    threshold        = var.sql_db_app_cpu_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.sql_db_app_cpu_action_group_ids) > 0 ? var.sql_db_app_cpu_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# App Memory Percent Alert (Serverless)
resource "azurerm_monitor_metric_alert" "sql_db_app_memory" {
  for_each = var.sql_database_serverless_ids

  name                = "alrt-mem-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when SQL Database app_memory_percent (Average) over ${var.sql_db_app_memory_window_size} is above ${var.sql_db_app_memory_threshold}%."

  severity      = var.sql_db_app_memory_severity
  enabled       = var.sql_db_app_memory_enabled
  auto_mitigate = var.sql_db_app_memory_auto_mitigate
  tags          = var.tags

  frequency   = var.sql_db_app_memory_frequency
  window_size = var.sql_db_app_memory_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "app_memory_percent"
    aggregation      = var.sql_db_app_memory_aggregation
    operator         = var.sql_db_app_memory_operator
    threshold        = var.sql_db_app_memory_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.sql_db_app_memory_action_group_ids) > 0 ? var.sql_db_app_memory_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# SQL Instance CPU Percent Alert (Provisioned)
resource "azurerm_monitor_metric_alert" "sql_db_instance_cpu" {
  for_each = var.sql_database_provisioned_ids

  name                = "alrt-sqlcpu-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when SQL Database sql_instance_cpu_percent (Average) over ${var.sql_db_instance_cpu_window_size} is above ${var.sql_db_instance_cpu_threshold}%."

  severity      = var.sql_db_instance_cpu_severity
  enabled       = var.sql_db_instance_cpu_enabled
  auto_mitigate = var.sql_db_instance_cpu_auto_mitigate
  tags          = var.tags

  frequency   = var.sql_db_instance_cpu_frequency
  window_size = var.sql_db_instance_cpu_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "sql_instance_cpu_percent"
    aggregation      = var.sql_db_instance_cpu_aggregation
    operator         = var.sql_db_instance_cpu_operator
    threshold        = var.sql_db_instance_cpu_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.sql_db_instance_cpu_action_group_ids) > 0 ? var.sql_db_instance_cpu_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# SQL Instance Memory Percent Alert (Provisioned)
resource "azurerm_monitor_metric_alert" "sql_db_instance_memory" {
  for_each = var.sql_database_provisioned_ids

  name                = "alrt-sqlmem-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when SQL Database sql_instance_memory_percent (Average) over ${var.sql_db_instance_memory_window_size} is above ${var.sql_db_instance_memory_threshold}%."

  severity      = var.sql_db_instance_memory_severity
  enabled       = var.sql_db_instance_memory_enabled
  auto_mitigate = var.sql_db_instance_memory_auto_mitigate
  tags          = var.tags

  frequency   = var.sql_db_instance_memory_frequency
  window_size = var.sql_db_instance_memory_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "sql_instance_memory_percent"
    aggregation      = var.sql_db_instance_memory_aggregation
    operator         = var.sql_db_instance_memory_operator
    threshold        = var.sql_db_instance_memory_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.sql_db_instance_memory_action_group_ids) > 0 ? var.sql_db_instance_memory_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

########################################
# Key Vault Alerts
########################################

# Availability Alert
resource "azurerm_monitor_metric_alert" "key_vault_availability" {
  for_each = var.key_vault_ids

  name                = "alrt-avail-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when Key Vault Availability (Average) over ${var.key_vault_availability_window_size} is below ${var.key_vault_availability_threshold}%."

  severity      = var.key_vault_availability_severity
  enabled       = var.key_vault_availability_enabled
  auto_mitigate = var.key_vault_availability_auto_mitigate
  tags          = var.tags

  frequency   = var.key_vault_availability_frequency
  window_size = var.key_vault_availability_window_size

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "Availability"
    aggregation      = var.key_vault_availability_aggregation
    operator         = var.key_vault_availability_operator
    threshold        = var.key_vault_availability_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.key_vault_availability_action_group_ids) > 0 ? var.key_vault_availability_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# Saturation Alert
resource "azurerm_monitor_metric_alert" "key_vault_saturation" {
  for_each = var.key_vault_ids

  name                = "alrt-sat-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when Key Vault SaturationShoebox (Average) over ${var.key_vault_saturation_window_size} is above ${var.key_vault_saturation_threshold}%."

  severity      = var.key_vault_saturation_severity
  enabled       = var.key_vault_saturation_enabled
  auto_mitigate = var.key_vault_saturation_auto_mitigate
  tags          = var.tags

  frequency   = var.key_vault_saturation_frequency
  window_size = var.key_vault_saturation_window_size

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "SaturationShoebox"
    aggregation      = var.key_vault_saturation_aggregation
    operator         = var.key_vault_saturation_operator
    threshold        = var.key_vault_saturation_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.key_vault_saturation_action_group_ids) > 0 ? var.key_vault_saturation_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

########################################
# Storage Account Alerts
########################################

# Availability Alert
resource "azurerm_monitor_metric_alert" "storage_availability" {
  for_each = var.storage_account_ids

  name                = "alrt-avail-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when Storage Account availability (Average) over ${var.storage_availability_window_size} is below ${var.storage_availability_threshold}%."

  severity      = var.storage_availability_severity
  enabled       = var.storage_availability_enabled
  auto_mitigate = var.storage_availability_auto_mitigate
  tags          = var.tags

  frequency   = var.storage_availability_frequency
  window_size = var.storage_availability_window_size

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Availability"
    aggregation      = var.storage_availability_aggregation
    operator         = var.storage_availability_operator
    threshold        = var.storage_availability_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.storage_availability_action_group_ids) > 0 ? var.storage_availability_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# Success Server Latency Alert
resource "azurerm_monitor_metric_alert" "storage_latency" {
  for_each = var.storage_account_ids

  name                = "alrt-sslat-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when Storage Account Success Server Latency (Average) over ${var.storage_latency_window_size} is above ${var.storage_latency_threshold}ms."

  severity      = var.storage_latency_severity
  enabled       = var.storage_latency_enabled
  auto_mitigate = var.storage_latency_auto_mitigate
  tags          = var.tags

  frequency   = var.storage_latency_frequency
  window_size = var.storage_latency_window_size

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "SuccessServerLatency"
    aggregation      = var.storage_latency_aggregation
    operator         = var.storage_latency_operator
    threshold        = var.storage_latency_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.storage_latency_action_group_ids) > 0 ? var.storage_latency_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# Used Capacity Alert
resource "azurerm_monitor_metric_alert" "storage_used_capacity" {
  for_each = var.storage_account_ids

  name                = "alrt-used-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when Storage Account UsedCapacity (Average) over ${var.storage_used_capacity_window_size} is above ${var.storage_used_capacity_threshold} bytes."

  severity      = var.storage_used_capacity_severity
  enabled       = var.storage_used_capacity_enabled
  auto_mitigate = var.storage_used_capacity_auto_mitigate
  tags          = var.tags

  frequency   = var.storage_used_capacity_frequency
  window_size = var.storage_used_capacity_window_size

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "UsedCapacity"
    aggregation      = var.storage_used_capacity_aggregation
    operator         = var.storage_used_capacity_operator
    threshold        = var.storage_used_capacity_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.storage_used_capacity_action_group_ids) > 0 ? var.storage_used_capacity_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

########################################
# AI Search Alerts
########################################

# Search Latency Alert
resource "azurerm_monitor_metric_alert" "ai_search_latency" {
  for_each = var.ai_search_ids

  name                = "alrt-lat-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when SearchLatency (Average) over ${var.ai_search_latency_window_size} is above ${var.ai_search_latency_threshold}ms."

  severity      = var.ai_search_latency_severity
  enabled       = var.ai_search_latency_enabled
  auto_mitigate = var.ai_search_latency_auto_mitigate
  tags          = var.tags

  frequency   = var.ai_search_latency_frequency
  window_size = var.ai_search_latency_window_size

  criteria {
    metric_namespace = "Microsoft.Search/searchServices"
    metric_name      = "SearchLatency"
    aggregation      = var.ai_search_latency_aggregation
    operator         = var.ai_search_latency_operator
    threshold        = var.ai_search_latency_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.ai_search_latency_action_group_ids) > 0 ? var.ai_search_latency_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# Throttled Search Queries Percentage Alert
resource "azurerm_monitor_metric_alert" "ai_search_throttled" {
  for_each = var.ai_search_ids

  name                = "alrt-thrpct-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when ThrottledSearchQueriesPercentage (Average) over ${var.ai_search_throttled_window_size} is above ${var.ai_search_throttled_threshold}%."

  severity      = var.ai_search_throttled_severity
  enabled       = var.ai_search_throttled_enabled
  auto_mitigate = var.ai_search_throttled_auto_mitigate
  tags          = var.tags

  frequency   = var.ai_search_throttled_frequency
  window_size = var.ai_search_throttled_window_size

  criteria {
    metric_namespace = "Microsoft.Search/searchServices"
    metric_name      = "ThrottledSearchQueriesPercentage"
    aggregation      = var.ai_search_throttled_aggregation
    operator         = var.ai_search_throttled_operator
    threshold        = var.ai_search_throttled_threshold
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.ai_search_throttled_action_group_ids) > 0 ? var.ai_search_throttled_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

########################################
# AI Services Alerts
########################################

# Availability Rate Alert
resource "azurerm_monitor_metric_alert" "ai_services_availability" {
  for_each = var.ai_services_ids

  name                = "alrt-avail-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when AzureOpenAIAvailabilityRate (Average) over ${var.ai_services_availability_window_size} is below ${var.ai_services_availability_threshold}%."

  severity      = var.ai_services_availability_severity
  enabled       = var.ai_services_availability_enabled
  auto_mitigate = var.ai_services_availability_auto_mitigate
  tags          = var.tags

  frequency   = var.ai_services_availability_frequency
  window_size = var.ai_services_availability_window_size

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = "AzureOpenAIAvailabilityRate"
    aggregation      = var.ai_services_availability_aggregation
    operator         = var.ai_services_availability_operator
    threshold        = var.ai_services_availability_threshold

    dynamic "dimension" {
      for_each = [1]
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = length(var.ai_services_availability_model_deployment_names) > 0 ? var.ai_services_availability_model_deployment_names : ["*"]
      }
    }
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.ai_services_availability_action_group_ids) > 0 ? var.ai_services_availability_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# Processed Tokens Alert
resource "azurerm_monitor_metric_alert" "ai_services_tokens" {
  for_each = var.ai_services_ids

  name                = "alrt-tok-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when Processed Inference Tokens (Total) over ${var.ai_services_tokens_window_size} is above ${var.ai_services_tokens_threshold}."

  severity      = var.ai_services_tokens_severity
  enabled       = var.ai_services_tokens_enabled
  auto_mitigate = var.ai_services_tokens_auto_mitigate
  tags          = var.tags

  frequency   = var.ai_services_tokens_frequency
  window_size = var.ai_services_tokens_window_size

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = "TokenTransaction"
    aggregation      = var.ai_services_tokens_aggregation
    operator         = var.ai_services_tokens_operator
    threshold        = var.ai_services_tokens_threshold

    dynamic "dimension" {
      for_each = [1]
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = length(var.ai_services_tokens_model_deployment_names) > 0 ? var.ai_services_tokens_model_deployment_names : ["*"]
      }
    }
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.ai_services_tokens_action_group_ids) > 0 ? var.ai_services_tokens_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# Time To First Token Alert
resource "azurerm_monitor_metric_alert" "ai_services_ttft" {
  for_each = var.ai_services_ids

  name                = "alrt-ttft-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when AzureOpenAINormalizedTTFTInMS (Average) over ${var.ai_services_ttft_window_size} is above ${var.ai_services_ttft_threshold}ms."

  severity      = var.ai_services_ttft_severity
  enabled       = var.ai_services_ttft_enabled
  auto_mitigate = var.ai_services_ttft_auto_mitigate
  tags          = var.tags

  frequency   = var.ai_services_ttft_frequency
  window_size = var.ai_services_ttft_window_size

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = "AzureOpenAINormalizedTTFTInMS"
    aggregation      = var.ai_services_ttft_aggregation
    operator         = var.ai_services_ttft_operator
    threshold        = var.ai_services_ttft_threshold

    dynamic "dimension" {
      for_each = [1]
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = length(var.ai_services_ttft_model_deployment_names) > 0 ? var.ai_services_ttft_model_deployment_names : ["*"]
      }
    }
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.ai_services_ttft_action_group_ids) > 0 ? var.ai_services_ttft_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}

# Time To Last Token Alert
resource "azurerm_monitor_metric_alert" "ai_services_ttlt" {
  for_each = var.ai_services_ids

  name                = "alrt-ttlt-${each.key}"
  resource_group_name = data.azurerm_resource_group.this.name
  scopes              = [each.value]

  description = "Alert when AzureOpenAITTLTInMS (Average) over ${var.ai_services_ttlt_window_size} is above ${var.ai_services_ttlt_threshold}ms."

  severity      = var.ai_services_ttlt_severity
  enabled       = var.ai_services_ttlt_enabled
  auto_mitigate = var.ai_services_ttlt_auto_mitigate
  tags          = var.tags

  frequency   = var.ai_services_ttlt_frequency
  window_size = var.ai_services_ttlt_window_size

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = "AzureOpenAITTLTInMS"
    aggregation      = var.ai_services_ttlt_aggregation
    operator         = var.ai_services_ttlt_operator
    threshold        = var.ai_services_ttlt_threshold

    dynamic "dimension" {
      for_each = [1]
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = length(var.ai_services_ttlt_model_deployment_names) > 0 ? var.ai_services_ttlt_model_deployment_names : ["*"]
      }
    }
  }

  dynamic "action" {
    for_each = var.action_group_id != null ? [var.action_group_id] : (length(var.ai_services_ttlt_action_group_ids) > 0 ? var.ai_services_ttlt_action_group_ids : [local.default_action_group_id])
    content {
      action_group_id = action.value
    }
  }
}
