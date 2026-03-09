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
  value       = data.azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = data.azurerm_resource_group.this.name
}

########################################
# Networking (Inputs used by Private Endpoints)
########################################
output "private_endpoints_subnet_id" {
  description = "Subnet ID used for Private Endpoints."
  value       = data.azurerm_subnet.private_endpoints.id
}

########################################
# Storage Account
########################################
output "storage_account_id" {
  description = "Storage Account ID."
  value       = module.storage_account.storage_account_id
}

output "storage_account_name" {
  description = "Storage Account name."
  value       = module.storage_account.storage_account_name
}

output "storage_account_primary_blob_endpoint" {
  description = "Storage Account primary blob endpoint."
  value       = module.storage_account.storage_account_primary_blob_endpoint
}

########################################
# Private Endpoints
########################################
output "private_endpoint_blob_id" {
  description = "Blob Private Endpoint ID (if created)."
  value       = module.storage_account.private_endpoint_blob_id
}

output "private_endpoint_file_id" {
  description = "File Private Endpoint ID (if created)."
  value       = module.storage_account.private_endpoint_file_id
}

########################################
# Storage Account Alerts
########################################
output "storage_account_availability_alert_id" {
  description = "Storage Account Availability alert ID (null if disabled)."
  value       = module.storage_account.availability_alert_id
}

output "storage_account_availability_alert_name" {
  description = "Storage Account Availability alert name (null if disabled)."
  value       = module.storage_account.availability_alert_name
}

output "storage_account_success_server_latency_alert_id" {
  description = "Storage Account Success Server Latency alert ID (null if disabled)."
  value       = module.storage_account.success_server_latency_alert_id
}

output "storage_account_success_server_latency_alert_name" {
  description = "Storage Account Success Server Latency alert name (null if disabled)."
  value       = module.storage_account.success_server_latency_alert_name
}

output "storage_account_used_capacity_alert_id" {
  description = "Storage Account Used Capacity alert ID (null if disabled)."
  value       = module.storage_account.used_capacity_alert_id
}

output "storage_account_used_capacity_alert_name" {
  description = "Storage Account Used Capacity alert name (null if disabled)."
  value       = module.storage_account.used_capacity_alert_name
}

########################################
# Role Assignments
########################################
output "role_assignments_storage_account" {
  description = "Map of role assignment IDs created for Storage Account RBAC, keyed by assignment alias."
  value       = module.rbac_storage_account.role_assignment_ids
}

########################################
# Action Group
########################################
output "action_group_id" {
  description = "Resource ID of the action group created by this template (if any)."
  value       = try(module.action_group[0].action_group_id, null)
}

output "action_group_name" {
  description = "Name of the action group created by this template (if any)."
  value       = try(module.action_group[0].action_group_name, null)
}

########################################
# Tier Information
########################################
output "selected_tier" {
  description = "The tier that was deployed (tier1 or tier2)."
  value       = var.tier
}

