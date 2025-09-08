output "id" {
  value       = azurerm_key_vault.this.id
  description = "The ID of the Key Vault."
}

output "name" {
  value       = azurerm_key_vault.this.name
  description = "The name of the Key Vault."
}

output "vault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the Key Vault (e.g., https://<name>.vault.azure.net/)."
}

output "private_endpoint_id" {
  value       = try(azurerm_private_endpoint.this[0].id, null)
  description = "The ID of the Private Endpoint if created, otherwise null."
}

########################################
# Alert Outputs
########################################

output "availability_alert_id" {
  value       = try(azurerm_monitor_metric_alert.availability[0].id, null)
  description = "Resource ID of the Availability metric alert (null if disabled)."
}

output "availability_alert_name" {
  value       = try(azurerm_monitor_metric_alert.availability[0].name, null)
  description = "Name of the Availability metric alert (null if disabled)."
}

output "saturation_alert_id" {
  value       = try(azurerm_monitor_metric_alert.saturation[0].id, null)
  description = "Resource ID of the Saturation metric alert (null if disabled)."
}

output "saturation_alert_name" {
  value       = try(azurerm_monitor_metric_alert.saturation[0].name, null)
  description = "Name of the Saturation metric alert (null if disabled)."
}
