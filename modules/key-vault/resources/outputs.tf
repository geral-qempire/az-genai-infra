output "id" {
  description = "The resource ID of the Key Vault."
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.this.name
}

output "vault_uri" {
  description = "The URI of the Key Vault for data plane operations."
  value       = azurerm_key_vault.this.vault_uri
}

output "tenant_id" {
  description = "The tenant ID the Key Vault is associated with."
  value       = azurerm_key_vault.this.tenant_id
}

output "sku_name" {
  description = "The SKU name of the Key Vault."
  value       = azurerm_key_vault.this.sku_name
}

output "soft_delete_retention_days" {
  description = "Soft delete retention period (days)."
  value       = azurerm_key_vault.this.soft_delete_retention_days
}

output "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  value       = azurerm_key_vault.this.public_network_access_enabled
}
