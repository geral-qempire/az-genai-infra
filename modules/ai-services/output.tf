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
