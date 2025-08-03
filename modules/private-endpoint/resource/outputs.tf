output "id" {
  description = "The resource ID of the Private Endpoint."
  value       = azurerm_private_endpoint.this.id
}

output "name" {
  description = "The name of the Private Endpoint."
  value       = azurerm_private_endpoint.this.name
}

output "custom_network_interface_name" {
  description = "The name of the NIC created for the Private Endpoint."
  value       = azurerm_private_endpoint.this.custom_network_interface_name
}
