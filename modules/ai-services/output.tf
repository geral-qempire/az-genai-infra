output "ai_services_id" {
  value       = azurerm_ai_services.this.id
  description = "The ID of the AI Services resource."
}

output "ai_services_name" {
  value       = azurerm_ai_services.this.name
  description = "The Name of the AI Services resource."
}

output "ai_services_primary_key" {
  value       = azurerm_ai_services.this.primary_access_key
  description = "Primary access key for the AI Services account."
  sensitive   = true
}

output "ai_services_secondary_key" {
  value       = azurerm_ai_services.this.secondary_access_key
  description = "Secondary access key for the AI Services account."
  sensitive   = true
}

output "private_endpoint_id" {
  value       = try(azurerm_private_endpoint.this[0].id, null)
  description = "The ID of the Private Endpoint if created, otherwise null."
}



output "managed_identity_principal_id" {
  value       = try(azurerm_ai_services.this.identity[0].principal_id, null)
  description = "Principal ID of the system-assigned managed identity."
}

########################################
# Alert Outputs
########################################

output "availability_rate_alert_id" {
  value       = try(azurerm_monitor_metric_alert.availability_rate[0].id, null)
  description = "Resource ID of the AvailabilityRate metric alert (null if disabled)."
}

output "availability_rate_alert_name" {
  value       = try(azurerm_monitor_metric_alert.availability_rate[0].name, null)
  description = "Name of the AvailabilityRate metric alert (null if disabled)."
}

output "processed_tokens_alert_id" {
  value       = try(azurerm_monitor_metric_alert.processed_tokens[0].id, null)
  description = "Resource ID of the ProcessedTokens metric alert (null if disabled)."
}

output "processed_tokens_alert_name" {
  value       = try(azurerm_monitor_metric_alert.processed_tokens[0].name, null)
  description = "Name of the ProcessedTokens metric alert (null if disabled)."
}

output "ttft_alert_id" {
  value       = try(azurerm_monitor_metric_alert.ttft[0].id, null)
  description = "Resource ID of the TTFT metric alert (null if disabled)."
}

output "ttft_alert_name" {
  value       = try(azurerm_monitor_metric_alert.ttft[0].name, null)
  description = "Name of the TTFT metric alert (null if disabled)."
}

output "ttlt_alert_id" {
  value       = try(azurerm_monitor_metric_alert.ttlt[0].id, null)
  description = "Resource ID of the TTLT metric alert (null if disabled)."
}

output "ttlt_alert_name" {
  value       = try(azurerm_monitor_metric_alert.ttlt[0].name, null)
  description = "Name of the TTLT metric alert (null if disabled)."
}
