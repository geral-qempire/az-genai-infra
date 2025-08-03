output "resource_group_name" {
  description = "Name of the test resource group."
  value       = azurerm_resource_group.test.name
}

output "key_vault_id" {
  description = "Azure resource ID of the Key Vault."
  value       = azurerm_key_vault.test.id
}

output "key_vault_name" {
  description = "Name of the Key Vault."
  value       = azurerm_key_vault.test.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault."
  value       = azurerm_key_vault.test.vault_uri
}

output "private_endpoint_id" {
  description = "Azure resource ID of the Private Endpoint."
  value       = module.private_endpoint.id
}

output "private_endpoint_name" {
  description = "Name of the Private Endpoint."
  value       = module.private_endpoint.name
}

output "private_endpoint_nic_name" {
  description = "Name of the Network Interface created for the Private Endpoint."
  value       = module.private_endpoint.custom_network_interface_name
}

output "subnet_id" {
  description = "ID of the subnet used for the Private Endpoint."
  value       = data.azurerm_subnet.existing.id
}

output "private_dns_zone_id" {
  description = "ID of the Private DNS Zone used."
  value       = data.azurerm_private_dns_zone.keyvault.id
}

output "test_instructions" {
  description = "Instructions for testing the private endpoint connectivity."
  value = <<-EOT
    Test your private endpoint:
    1. Connect to a VM in the same VNet
    2. Run: nslookup ${azurerm_key_vault.test.name}.vault.azure.net
    3. The result should resolve to a private IP address (10.x.x.x or 172.x.x.x or 192.168.x.x)
    4. Test Key Vault access: az keyvault secret set --vault-name ${azurerm_key_vault.test.name} --name test-secret --value "Hello Private Endpoint"
  EOT
} 