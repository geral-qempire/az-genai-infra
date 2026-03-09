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
# Key Vault
########################################
output "key_vault_id" {
  description = "Key Vault ID."
  value       = module.key_vault.id
}

output "key_vault_name" {
  description = "Key Vault name."
  value       = module.key_vault.name
}

output "key_vault_uri" {
  description = "Key Vault URI."
  value       = module.key_vault.vault_uri
}

output "key_vault_private_endpoint_id" {
  description = "Key Vault Private Endpoint ID (if created)."
  value       = module.key_vault.private_endpoint_id
}

########################################
# Key Vault Alerts
########################################
output "key_vault_availability_alert_id" {
  description = "Key Vault Availability alert ID (null if disabled)."
  value       = module.key_vault.availability_alert_id
}

output "key_vault_availability_alert_name" {
  description = "Key Vault Availability alert name (null if disabled)."
  value       = module.key_vault.availability_alert_name
}

output "key_vault_saturation_alert_id" {
  description = "Key Vault Saturation alert ID (null if disabled)."
  value       = module.key_vault.saturation_alert_id
}

output "key_vault_saturation_alert_name" {
  description = "Key Vault Saturation alert name (null if disabled)."
  value       = module.key_vault.saturation_alert_name
}

########################################
# Role Assignments
########################################
output "role_assignments_key_vault" {
  description = "Map of role assignment IDs created for Key Vault RBAC, keyed by assignment alias."
  value       = module.rbac_key_vault.role_assignment_ids
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

