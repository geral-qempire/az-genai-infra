########################################
# Resource Group
########################################
output "resource_group_name" {
  description = "Name of the networking resource group."
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "ID of the networking resource group."
  value       = azurerm_resource_group.this.id
}

########################################
# Virtual Network
########################################
output "vnet_name" {
  description = "Name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

output "vnet_id" {
  description = "ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

########################################
# Subnets
########################################
output "subnet_dev_name" {
  description = "Name of the dev subnet."
  value       = azurerm_subnet.dev.name
}

output "subnet_dev_id" {
  description = "ID of the dev subnet."
  value       = azurerm_subnet.dev.id
}

output "subnet_qua_name" {
  description = "Name of the qua subnet."
  value       = azurerm_subnet.qua.name
}

output "subnet_qua_id" {
  description = "ID of the qua subnet."
  value       = azurerm_subnet.qua.id
}

output "subnet_prd_name" {
  description = "Name of the prd subnet."
  value       = azurerm_subnet.prd.name
}

output "subnet_prd_id" {
  description = "ID of the prd subnet."
  value       = azurerm_subnet.prd.id
}
