output "storage_account_id" {
  value       = azurerm_storage_account.this.id
  description = "The ID of the Storage Account."
}

output "storage_account_name" {
  value       = azurerm_storage_account.this.name
  description = "The Name of the Storage Account."
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.this.primary_access_key
  description = "Primary access key for the Storage Account."
  sensitive   = true
}

output "storage_account_primary_blob_endpoint" {
  value       = azurerm_storage_account.this.primary_blob_endpoint
  description = "Primary Blob service endpoint for the Storage Account."
}

# Private Endpoint IDs (if created)
output "private_endpoint_blob_id" {
  value       = try(azurerm_private_endpoint.blob[0].id, null)
  description = "The ID of the Blob private endpoint if created, otherwise null."
}

output "private_endpoint_file_id" {
  value       = try(azurerm_private_endpoint.file[0].id, null)
  description = "The ID of the File private endpoint if created, otherwise null."
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

output "success_server_latency_alert_id" {
  value       = try(azurerm_monitor_metric_alert.success_server_latency[0].id, null)
  description = "Resource ID of the success server latency metric alert (null if disabled)."
}

output "success_server_latency_alert_name" {
  value       = try(azurerm_monitor_metric_alert.success_server_latency[0].name, null)
  description = "Name of the success server latency metric alert (null if disabled)."
}

output "used_capacity_alert_id" {
  value       = try(azurerm_monitor_metric_alert.used_capacity[0].id, null)
  description = "Resource ID of the used capacity metric alert (null if disabled)."
}

output "used_capacity_alert_name" {
  value       = try(azurerm_monitor_metric_alert.used_capacity[0].name, null)
  description = "Name of the used capacity metric alert (null if disabled)."
}


