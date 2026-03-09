output "resource_group_name" {
  description = "Name of the created resource group."
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "ID of the created resource group."
  value       = azurerm_resource_group.this.id
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace."
  value       = module.log_analytics_workspace.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  value       = module.log_analytics_workspace.log_analytics_workspace_name
}

output "log_analytics_workspace_customer_id" {
  description = "Immutable Workspace (Customer) ID (GUID)."
  value       = module.log_analytics_workspace.log_analytics_workspace_customer_id
}
