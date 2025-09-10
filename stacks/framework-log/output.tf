########################################
# Deployment Context
########################################
output "location" {
  description = "Azure region where resources are deployed."
  value       = var.location
}

output "tags" {
  description = "Tags applied to all resources created by this template."
  value       = var.tags
}

########################################
# Resource Group
########################################
output "resource_group_id" {
  description = "Resource Group ID."
  value       = azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = azurerm_resource_group.this.name
}

########################################
# Log Analytics Workspace
########################################
output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID."
  value       = module.log_analytics_workspace.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name."
  value       = module.log_analytics_workspace.log_analytics_workspace_name
}

########################################
# Role Assignments
########################################
output "role_assignments_groups" {
  description = "Map of role assignment IDs created for AD Groups, keyed by assignment alias."
  value       = try(module.rbac_ad_groups.role_assignment_ids, {})
}

 


