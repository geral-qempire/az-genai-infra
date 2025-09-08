output "id" {
  value       = azurerm_mssql_database.this.id
  description = "The ID of the SQL database."
}

output "name" {
  value       = azurerm_mssql_database.this.name
  description = "The name of the SQL database."
}

output "identity_ids" {
  value       = try(azurerm_mssql_database.this.identity[0].identity_ids, null)
  description = "The list of User Assigned Identity IDs attached to the database, or null if none."
}

########################################
# Alert Outputs
########################################

output "availability_alert_id" {
  value       = try(azurerm_monitor_metric_alert.availability[0].id, null)
  description = "Resource ID of the availability metric alert (null if disabled)."
}

output "availability_alert_name" {
  value       = try(azurerm_monitor_metric_alert.availability[0].name, null)
  description = "Name of the availability metric alert (null if disabled)."
}

output "storage_alert_id" {
  value       = try(azurerm_monitor_metric_alert.storage[0].id, null)
  description = "Resource ID of the storage metric alert (null if disabled)."
}

output "storage_alert_name" {
  value       = try(azurerm_monitor_metric_alert.storage[0].name, null)
  description = "Name of the storage metric alert (null if disabled)."
}

output "app_cpu_alert_id" {
  value       = try(azurerm_monitor_metric_alert.app_cpu[0].id, null)
  description = "Resource ID of the app CPU metric alert (null if disabled or non-serverless)."
}

output "app_cpu_alert_name" {
  value       = try(azurerm_monitor_metric_alert.app_cpu[0].name, null)
  description = "Name of the app CPU metric alert (null if disabled or non-serverless)."
}

output "app_memory_alert_id" {
  value       = try(azurerm_monitor_metric_alert.app_memory[0].id, null)
  description = "Resource ID of the app memory metric alert (null if disabled or non-serverless)."
}

output "app_memory_alert_name" {
  value       = try(azurerm_monitor_metric_alert.app_memory[0].name, null)
  description = "Name of the app memory metric alert (null if disabled or non-serverless)."
}

output "sql_instance_cpu_alert_id" {
  value       = try(azurerm_monitor_metric_alert.sql_instance_cpu[0].id, null)
  description = "Resource ID of the SQL instance CPU metric alert (null if disabled or serverless)."
}

output "sql_instance_cpu_alert_name" {
  value       = try(azurerm_monitor_metric_alert.sql_instance_cpu[0].name, null)
  description = "Name of the SQL instance CPU metric alert (null if disabled or serverless)."
}

output "sql_instance_memory_alert_id" {
  value       = try(azurerm_monitor_metric_alert.sql_instance_memory[0].id, null)
  description = "Resource ID of the SQL instance memory metric alert (null if disabled or serverless)."
}

output "sql_instance_memory_alert_name" {
  value       = try(azurerm_monitor_metric_alert.sql_instance_memory[0].name, null)
  description = "Name of the SQL instance memory metric alert (null if disabled or serverless)."
}


