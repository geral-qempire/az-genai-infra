########################################
# Alerts - Azure SQL Database
########################################

locals {
  database_resource_name = azurerm_mssql_database.this.name

  # Default alert names following the pattern alrt-<metric-abbreviation>-<resource-name>
  default_avail_alert_name  = "alrt-avail-${local.database_resource_name}"
  default_stor_alert_name   = "alrt-stor-${local.database_resource_name}"
  default_cpu_alert_name    = "alrt-cpu-${local.database_resource_name}"
  default_mem_alert_name    = "alrt-mem-${local.database_resource_name}"
  default_sqlcpu_alert_name = "alrt-sqlcpu-${local.database_resource_name}"
  default_sqlmem_alert_name = "alrt-sqlmem-${local.database_resource_name}"
}

########################################
# Availability Alert (Common)
########################################
resource "azurerm_monitor_metric_alert" "availability" {
  count               = var.enable_availability_alert ? 1 : 0
  name                = coalesce(var.availability_alert_name, local.default_avail_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.this.id]

  description = coalesce(
    var.availability_alert_description,
    "Alert when SQL Database availability (Average) over ${var.availability_alert_window_size} is below ${var.availability_alert_threshold}%."
  )

  severity      = var.availability_alert_severity
  enabled       = var.availability_alert_enabled
  auto_mitigate = var.availability_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.availability_alert_frequency
  window_size = var.availability_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "availability"
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
# Storage Percent Alert (Common)
########################################
resource "azurerm_monitor_metric_alert" "storage" {
  count               = var.enable_storage_alert ? 1 : 0
  name                = coalesce(var.storage_alert_name, local.default_stor_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.this.id]

  description = coalesce(
    var.storage_alert_description,
    "Alert when SQL Database storage_percent (Average) over ${var.storage_alert_window_size} is above ${var.storage_alert_threshold}%."
  )

  severity      = var.storage_alert_severity
  enabled       = var.storage_alert_enabled
  auto_mitigate = var.storage_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.storage_alert_frequency
  window_size = var.storage_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "storage_percent"
    aggregation      = var.storage_alert_aggregation
    operator         = var.storage_alert_operator
    threshold        = var.storage_alert_threshold
  }

  dynamic "action" {
    for_each = var.storage_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# App CPU Percent Alert (Serverless Only)
########################################
resource "azurerm_monitor_metric_alert" "app_cpu" {
  count               = var.enable_app_cpu_alert && var.is_serverless ? 1 : 0
  name                = coalesce(var.app_cpu_alert_name, local.default_cpu_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.this.id]

  description = coalesce(
    var.app_cpu_alert_description,
    "Alert when SQL Database app_cpu_percent (Average) over ${var.app_cpu_alert_window_size} is above ${var.app_cpu_alert_threshold}%."
  )

  severity      = var.app_cpu_alert_severity
  enabled       = var.app_cpu_alert_enabled
  auto_mitigate = var.app_cpu_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.app_cpu_alert_frequency
  window_size = var.app_cpu_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "app_cpu_percent"
    aggregation      = var.app_cpu_alert_aggregation
    operator         = var.app_cpu_alert_operator
    threshold        = var.app_cpu_alert_threshold
  }

  dynamic "action" {
    for_each = var.app_cpu_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# App Memory Percent Alert (Serverless Only)
########################################
resource "azurerm_monitor_metric_alert" "app_memory" {
  count               = var.enable_app_memory_alert && var.is_serverless ? 1 : 0
  name                = coalesce(var.app_memory_alert_name, local.default_mem_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.this.id]

  description = coalesce(
    var.app_memory_alert_description,
    "Alert when SQL Database app_memory_percent (Average) over ${var.app_memory_alert_window_size} is above ${var.app_memory_alert_threshold}%."
  )

  severity      = var.app_memory_alert_severity
  enabled       = var.app_memory_alert_enabled
  auto_mitigate = var.app_memory_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.app_memory_alert_frequency
  window_size = var.app_memory_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "app_memory_percent"
    aggregation      = var.app_memory_alert_aggregation
    operator         = var.app_memory_alert_operator
    threshold        = var.app_memory_alert_threshold
  }

  dynamic "action" {
    for_each = var.app_memory_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# SQL Instance CPU Percent Alert (Non-Serverless Only)
########################################
resource "azurerm_monitor_metric_alert" "sql_instance_cpu" {
  count               = var.enable_sql_instance_cpu_alert && !var.is_serverless ? 1 : 0
  name                = coalesce(var.sql_instance_cpu_alert_name, local.default_sqlcpu_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.this.id]

  description = coalesce(
    var.sql_instance_cpu_alert_description,
    "Alert when SQL Database sql_instance_cpu_percent (Average) over ${var.sql_instance_cpu_alert_window_size} is above ${var.sql_instance_cpu_alert_threshold}%."
  )

  severity      = var.sql_instance_cpu_alert_severity
  enabled       = var.sql_instance_cpu_alert_enabled
  auto_mitigate = var.sql_instance_cpu_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.sql_instance_cpu_alert_frequency
  window_size = var.sql_instance_cpu_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "sql_instance_cpu_percent"
    aggregation      = var.sql_instance_cpu_alert_aggregation
    operator         = var.sql_instance_cpu_alert_operator
    threshold        = var.sql_instance_cpu_alert_threshold
  }

  dynamic "action" {
    for_each = var.sql_instance_cpu_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# SQL Instance Memory Percent Alert (Non-Serverless Only)
########################################
resource "azurerm_monitor_metric_alert" "sql_instance_memory" {
  count               = var.enable_sql_instance_memory_alert && !var.is_serverless ? 1 : 0
  name                = coalesce(var.sql_instance_memory_alert_name, local.default_sqlmem_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_mssql_database.this.id]

  description = coalesce(
    var.sql_instance_memory_alert_description,
    "Alert when SQL Database sql_instance_memory_percent (Average) over ${var.sql_instance_memory_alert_window_size} is above ${var.sql_instance_memory_alert_threshold}%."
  )

  severity      = var.sql_instance_memory_alert_severity
  enabled       = var.sql_instance_memory_alert_enabled
  auto_mitigate = var.sql_instance_memory_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.sql_instance_memory_alert_frequency
  window_size = var.sql_instance_memory_alert_window_size

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "sql_instance_memory_percent"
    aggregation      = var.sql_instance_memory_alert_aggregation
    operator         = var.sql_instance_memory_alert_operator
    threshold        = var.sql_instance_memory_alert_threshold
  }

  dynamic "action" {
    for_each = var.sql_instance_memory_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}
