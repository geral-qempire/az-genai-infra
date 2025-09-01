output "ai_hub_id" {
  value       = azurerm_ai_foundry.this.id
  description = "The ID of the AI Hub resource."
}

output "ai_hub_name" {
  value       = azurerm_ai_foundry.this.name
  description = "The Name of the AI Hub resource."
}

output "private_endpoint_id" {
  value       = try(azurerm_private_endpoint.this[0].id, null)
  description = "The ID of the Private Endpoint if created, otherwise null."
}



output "managed_identity_principal_id" {
  value       = try(azurerm_ai_foundry.this.identity[0].principal_id, null)
  description = "Principal ID of the system-assigned managed identity."
}
