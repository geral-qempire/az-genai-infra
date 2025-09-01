########################################
# Outputs (to be populated)
########################################
output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "Name of the created resource group."
}

output "resource_group_id" {
  value       = azurerm_resource_group.this.id
  description = "ID of the created resource group."
}

output "ai_services_id" {
  value       = module.ai_services.ai_services_id
  description = "AI Services resource ID."
}

output "ai_project_id" {
  value       = module.ai_project.ai_project_id
  description = "AI Project ID."
}

output "ai_services_connection_id" {
  value       = try(module.ai_services_connection.connection_id, null)
  description = "AI Services connection ID (under the Project)."
}

########################################
# Role Assignments
########################################
output "role_assignments_groups" {
  description = "Map of role assignment IDs created for AD Groups, keyed by assignment alias."
  value       = try(module.rbac_ad_groups.role_assignment_ids, {})
}

output "role_assignments_managed_identities" {
  description = "Map of role assignment IDs created for Managed Identities, keyed by assignment alias."
  value       = try(module.rbac_managed_identities.role_assignment_ids, {})
}

output "role_assignments_service_principals" {
  description = "Map of role assignment IDs created for Service Principals, keyed by assignment alias."
  value       = try(module.rbac_service_principals.role_assignment_ids, {})
}


