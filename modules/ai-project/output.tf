output "ai_project_id" {
  value       = azurerm_ai_foundry_project.this.id
  description = "The ID of the AI Project."
}

output "ai_project_name" {
  value       = azurerm_ai_foundry_project.this.name
  description = "The name of the AI Project."
}

output "managed_identity_principal_id" {
  value       = try(azurerm_ai_foundry_project.this.identity[0].principal_id, null)
  description = "Principal ID of the system-assigned managed identity."
}


