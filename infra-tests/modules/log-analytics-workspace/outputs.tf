output "resource_group_name" {
  description = "Name of the test resource group."
  value       = azurerm_resource_group.test.name
}

output "workspace_id" {
  description = "Workspace/Customer GUID."
  value       = module.log_analytics_workspace.workspace_id
}

output "workspace_resource_id" {
  description = "Azure resource ID of the workspace."
  value       = module.log_analytics_workspace.id
}

output "workspace_primary_shared_key" {
  description = "Primary shared key (sensitive)."
  value       = module.log_analytics_workspace.primary_shared_key
  sensitive   = true
}

output "workspace_secondary_shared_key" {
  description = "Secondary shared key (sensitive)."
  value       = module.log_analytics_workspace.secondary_shared_key
  sensitive   = true
}
