output "resource_group_name" {
  description = "Name of the created resource group."
  value       = module.simple_usecase.resource_group_name
}

output "resource_group_id" {
  description = "ID of the created resource group."
  value       = module.simple_usecase.resource_group_id
}

output "ai_services_id" {
  description = "AI Services ID."
  value       = module.simple_usecase.ai_services_id
}

output "ai_project_id" {
  description = "AI Project ID."
  value       = module.simple_usecase.ai_project_id
}

output "ai_services_connection_id" {
  description = "AI Services connection ID (under the Project)."
  value       = module.simple_usecase.ai_services_connection_id
}


########################################
# Role Assignments
########################################
output "role_assignments_groups" {
  description = "Map of role assignment IDs created for AD Groups, keyed by assignment alias."
  value       = module.simple_usecase.role_assignments_groups
}

output "role_assignments_managed_identities" {
  description = "Map of role assignment IDs created for Managed Identities, keyed by assignment alias."
  value       = module.simple_usecase.role_assignments_managed_identities
}

output "role_assignments_service_principals" {
  description = "Map of role assignment IDs created for Service Principals, keyed by assignment alias."
  value       = module.simple_usecase.role_assignments_service_principals
}


