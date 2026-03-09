output "resource_group_name" {
  description = "Name of the networking resource group."
  value       = module.networking.resource_group_name
}

output "vnet_name" {
  description = "Name of the virtual network."
  value       = module.networking.vnet_name
}

output "vnet_id" {
  description = "ID of the virtual network."
  value       = module.networking.vnet_id
}

output "subnet_dev_name" {
  description = "Name of the dev subnet."
  value       = module.networking.subnet_dev_name
}

output "subnet_dev_id" {
  description = "ID of the dev subnet."
  value       = module.networking.subnet_dev_id
}

output "subnet_qua_name" {
  description = "Name of the qua subnet."
  value       = module.networking.subnet_qua_name
}

output "subnet_qua_id" {
  description = "ID of the qua subnet."
  value       = module.networking.subnet_qua_id
}

output "subnet_prd_name" {
  description = "Name of the prd subnet."
  value       = module.networking.subnet_prd_name
}

output "subnet_prd_id" {
  description = "ID of the prd subnet."
  value       = module.networking.subnet_prd_id
}
