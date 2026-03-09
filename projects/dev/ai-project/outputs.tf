########################################
# Resource Group
########################################
output "resource_group_id" {
  description = "Resource Group ID."
  value       = module.ai_project.resource_group_id
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = module.ai_project.resource_group_name
}

########################################
# AI Project
########################################
output "ai_project_id" {
  description = "AI Project resource ID."
  value       = module.ai_project.ai_project_id
}

output "ai_project_name" {
  description = "AI Project resource name."
  value       = module.ai_project.ai_project_name
}

output "ai_project_principal_id" {
  description = "Principal ID of the AI Project system-assigned managed identity."
  value       = module.ai_project.ai_project_principal_id
}

########################################
# AI Services
########################################
output "ai_services_id" {
  description = "AI Services resource ID."
  value       = module.ai_project.ai_services_id
}

output "ai_services_name" {
  description = "AI Services resource name."
  value       = module.ai_project.ai_services_name
}

########################################
# Connection
########################################
output "ai_services_connection_id" {
  description = "AI Services connection ID (under the Project)."
  value       = module.ai_project.ai_services_connection_id
}

########################################
# Alerts
########################################
output "ai_services_alert_ids" {
  description = "Map of AI Services alert IDs."
  value       = module.ai_project.ai_services_alert_ids
}

########################################
# Action Group
########################################
output "action_group_id" {
  description = "Action Group ID (null if not created)."
  value       = module.ai_project.action_group_id
}

output "action_group_name" {
  description = "Action Group name (null if not created)."
  value       = module.ai_project.action_group_name
}

########################################
# Role Assignments
########################################
output "role_assignments_groups" {
  description = "Map of role assignment IDs created for AD Groups, keyed by assignment alias."
  value       = module.ai_project.role_assignments_groups
}

output "role_assignments_managed_identities" {
  description = "Map of role assignment IDs created for Managed Identities, keyed by assignment alias."
  value       = module.ai_project.role_assignments_managed_identities
}

output "role_assignments_service_principals" {
  description = "Map of role assignment IDs created for Service Principals, keyed by assignment alias."
  value       = module.ai_project.role_assignments_service_principals
}
