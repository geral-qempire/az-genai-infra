output "storage_account_id" {
  value       = azurerm_storage_account.this.id
  description = "The ID of the Storage Account."
}

output "storage_account_name" {
  value       = azurerm_storage_account.this.name
  description = "The Name of the Storage Account."
}


