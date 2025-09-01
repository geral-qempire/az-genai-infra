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
# Networking (Inputs used by Private Endpoints)
########################################
output "private_endpoints_subnet_id" {
  description = "Subnet ID used for Private Endpoints."
  value       = data.azurerm_subnet.private_endpoints.id
}

########################################
# Log Analytics + Application Insights
########################################
output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID linked to Application Insights."
  value       = data.azurerm_log_analytics_workspace.this.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name."
  value       = var.log_analytics_workspace_name
}

output "application_insights_id" {
  description = "Application Insights ID."
  value       = module.application_insights.application_insights_id
}

output "application_insights_name" {
  description = "Application Insights name."
  value       = module.application_insights.application_insights_name
}

output "application_insights_connection_string" {
  description = "Application Insights connection string."
  value       = module.application_insights.connection_string
  sensitive   = true
}

output "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key (classic ingestion)."
  value       = module.application_insights.instrumentation_key
  sensitive   = true
}

output "application_insights_app_id" {
  description = "Application Insights App ID."
  value       = module.application_insights.application_insights_app_id
}

########################################
# SQL Server and Database
########################################
output "sql_server_id" {
  description = "SQL Server (logical server) ID."
  value       = module.sql_server.id
}

output "sql_server_name" {
  description = "SQL Server name."
  value       = module.sql_server.name
}

output "sql_server_fqdn" {
  description = "SQL Server fully qualified domain name."
  value       = module.sql_server.fully_qualified_domain_name
}

output "sql_server_principal_id" {
  description = "SQL Server managed identity principal ID (if enabled)."
  value       = module.sql_server.principal_id
}

output "sql_server_private_endpoint_id" {
  description = "SQL Server Private Endpoint ID (if created)."
  value       = module.sql_server.private_endpoint_id
}

output "sql_database_id" {
  description = "SQL Database ID."
  value       = module.sql_database.id
}

output "sql_database_name" {
  description = "SQL Database name."
  value       = module.sql_database.name
}

output "sql_database_identity_ids" {
  description = "User Assigned Identity IDs attached to the SQL Database (if any)."
  value       = module.sql_database.identity_ids
}

output "sql_database_auto_pause_delay_in_minutes" {
  description = "SQL Database auto-pause delay in minutes (null if not set)."
  value       = var.sql_database_auto_pause_delay_in_minutes
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
  description = "Storage Account primary Blob endpoint."
  value       = module.storage_account.storage_account_primary_blob_endpoint
}

########################################
# AI Search Service
########################################
output "ai_search_service_id" {
  description = "AI Search Service ID."
  value       = module.ai_search_service.search_service_id
}

output "ai_search_service_name" {
  description = "AI Search Service name."
  value       = module.ai_search_service.search_service_name
}

output "ai_search_service_managed_identity_principal_id" {
  description = "AI Search Service managed identity principal ID (if enabled)."
  value       = module.ai_search_service.managed_identity_principal_id
}

output "ai_search_service_private_endpoint_id" {
  description = "AI Search Service Private Endpoint ID (if created)."
  value       = module.ai_search_service.private_endpoint_id
}

########################################
# AI Services
########################################
output "ai_services_id" {
  description = "AI Services ID."
  value       = module.ai_services.ai_services_id
}

output "ai_services_name" {
  description = "AI Services name."
  value       = module.ai_services.ai_services_name
}

output "ai_services_managed_identity_principal_id" {
  description = "AI Services managed identity principal ID (if enabled)."
  value       = module.ai_services.managed_identity_principal_id
}

output "ai_services_private_endpoint_id" {
  description = "AI Services Private Endpoint ID (if created)."
  value       = module.ai_services.private_endpoint_id
}

########################################
# AI Hub and Connections
########################################
output "ai_hub_id" {
  description = "AI Hub ID."
  value       = module.ai_hub.ai_hub_id
}

output "ai_hub_name" {
  description = "AI Hub name."
  value       = module.ai_hub.ai_hub_name
}

output "ai_hub_managed_identity_principal_id" {
  description = "AI Hub managed identity principal ID (if enabled)."
  value       = module.ai_hub.managed_identity_principal_id
}

output "ai_hub_private_endpoint_id" {
  description = "AI Hub Private Endpoint ID (if created)."
  value       = module.ai_hub.private_endpoint_id
}

output "ai_services_hub_connection_id" {
  description = "AI Hub connection ID for AI Services (if created)."
  value       = try(module.ai_services_hub_connection.connection_id, null)
}

output "ai_services_hub_connection_name" {
  description = "AI Hub connection name for AI Services (if created)."
  value       = try(module.ai_services_hub_connection.connection_name, null)
}

output "ai_search_hub_connection_id" {
  description = "AI Hub connection ID for AI Search (if created)."
  value       = try(module.ai_search_hub_connection.connection_id, null)
}

output "ai_search_hub_connection_name" {
  description = "AI Hub connection name for AI Search (if created)."
  value       = try(module.ai_search_hub_connection.connection_name, null)
}

output "api_key_hub_connection_id" {
  description = "AI Hub API key connection ID (if created)."
  value       = try(module.api_key_hub_connection.connection_id, null)
}

output "api_key_hub_connection_name" {
  description = "AI Hub API key connection name (if created)."
  value       = try(module.api_key_hub_connection.connection_name, null)
}


########################################
# Role Assignments
########################################
output "role_assignments_groups" {
  description = "Map of role assignment IDs created for AD Groups, keyed by assignment alias."
  value       = module.rbac_ad_groups.role_assignment_ids
}

output "role_assignments_managed_identities" {
  description = "Map of role assignment IDs created for Managed Identities, keyed by assignment alias."
  value       = module.rbac_managed_identities.role_assignment_ids
}

output "role_assignments_service_principals" {
  description = "Map of role assignment IDs created for Service Principals, keyed by assignment alias."
  value       = module.rbac_service_principals.role_assignment_ids
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

