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


