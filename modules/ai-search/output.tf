output "search_service_id" {
  value       = azurerm_search_service.this.id
  description = "The ID of the Search Service."
}

output "search_service_name" {
  value       = azurerm_search_service.this.name
  description = "The Name of the Search Service."
}

output "search_service_primary_key" {
  value       = azurerm_search_service.this.primary_key
  description = "Primary admin key for the Search Service."
  sensitive   = true
}

output "private_endpoint_id" {
  value       = try(azurerm_private_endpoint.this[0].id, null)
  description = "The ID of the Private Endpoint if created, otherwise null."
}

output "managed_identity_principal_id" {
  value       = try(azurerm_search_service.this.identity[0].principal_id, null)
  description = "Principal ID of the system-assigned managed identity."
}