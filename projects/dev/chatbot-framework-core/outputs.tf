########################################
# Deployment Context
########################################
output "location" {
  description = "Azure region where resources are deployed."
  value       = module.framework-core.location
}

output "tags" {
  description = "Tags applied to all resources created by this stack."
  value       = module.framework-core.tags
}

output "action_group_id" {
  description = "Action Group ID used by alerts in this deployment (if provided)."
  value       = module.framework-core.action_group_id
}

########################################
# Resource Group
########################################
output "resource_group_id" {
  description = "Resource Group ID."
  value       = module.framework-core.resource_group_id
}

output "resource_group_name" {
  description = "Resource Group name."
  value       = module.framework-core.resource_group_name
}

########################################
# Networking
########################################
output "private_endpoints_subnet_id" {
  description = "Subnet ID used for Private Endpoints."
  value       = module.framework-core.private_endpoints_subnet_id
}

########################################
# Log Analytics + Application Insights
########################################
output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID."
  value       = module.framework-core.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name."
  value       = module.framework-core.log_analytics_workspace_name
}

output "application_insights_id" {
  description = "Application Insights ID."
  value       = module.framework-core.application_insights_id
}

output "application_insights_name" {
  description = "Application Insights name."
  value       = module.framework-core.application_insights_name
}

output "application_insights_connection_string" {
  description = "Application Insights connection string."
  value       = module.framework-core.application_insights_connection_string
  sensitive   = true
}

output "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key (classic ingestion)."
  value       = module.framework-core.application_insights_instrumentation_key
  sensitive   = true
}

output "application_insights_app_id" {
  description = "Application Insights App ID."
  value       = module.framework-core.application_insights_app_id
}

########################################
# SQL Server and Database
########################################
output "sql_server_id" {
  description = "SQL Server ID."
  value       = module.framework-core.sql_server_id
}

output "sql_server_name" {
  description = "SQL Server name."
  value       = module.framework-core.sql_server_name
}

output "sql_server_fqdn" {
  description = "SQL Server fully qualified domain name."
  value       = module.framework-core.sql_server_fqdn
}

output "sql_server_principal_id" {
  description = "SQL Server managed identity principal ID (if enabled)."
  value       = module.framework-core.sql_server_principal_id
}

output "sql_server_private_endpoint_id" {
  description = "SQL Server Private Endpoint ID (if created)."
  value       = module.framework-core.sql_server_private_endpoint_id
}

output "sql_database_id" {
  description = "SQL Database ID."
  value       = module.framework-core.sql_database_id
}

output "sql_database_name" {
  description = "SQL Database name."
  value       = module.framework-core.sql_database_name
}

output "sql_database_identity_ids" {
  description = "User Assigned Identity IDs attached to the SQL Database (if any)."
  value       = module.framework-core.sql_database_identity_ids
}

output "sql_database_auto_pause_delay_in_minutes" {
  description = "SQL Database auto-pause delay in minutes (null if not set)."
  value       = module.framework-core.sql_database_auto_pause_delay_in_minutes
}

########################################
# Key Vault
########################################
output "key_vault_id" {
  description = "Key Vault ID."
  value       = module.framework-core.key_vault_id
}

output "key_vault_name" {
  description = "Key Vault name."
  value       = module.framework-core.key_vault_name
}

output "key_vault_uri" {
  description = "Key Vault URI."
  value       = module.framework-core.key_vault_uri
}

output "key_vault_private_endpoint_id" {
  description = "Key Vault Private Endpoint ID (if created)."
  value       = module.framework-core.key_vault_private_endpoint_id
}

########################################
# Storage Account
########################################
output "storage_account_id" {
  description = "Storage Account ID."
  value       = module.framework-core.storage_account_id
}

output "storage_account_name" {
  description = "Storage Account name."
  value       = module.framework-core.storage_account_name
}

output "storage_account_primary_blob_endpoint" {
  description = "Storage Account primary Blob endpoint."
  value       = module.framework-core.storage_account_primary_blob_endpoint
}

########################################
# AI Search Service
########################################
output "ai_search_service_id" {
  description = "AI Search Service ID."
  value       = module.framework-core.ai_search_service_id
}

output "ai_search_service_name" {
  description = "AI Search Service name."
  value       = module.framework-core.ai_search_service_name
}

output "ai_search_service_managed_identity_principal_id" {
  description = "AI Search Service managed identity principal ID (if enabled)."
  value       = module.framework-core.ai_search_service_managed_identity_principal_id
}

output "ai_search_service_private_endpoint_id" {
  description = "AI Search Service Private Endpoint ID (if created)."
  value       = module.framework-core.ai_search_service_private_endpoint_id
}

########################################
# AI Services
########################################
output "ai_services_id" {
  description = "AI Services ID."
  value       = module.framework-core.ai_services_id
}

output "ai_services_name" {
  description = "AI Services name."
  value       = module.framework-core.ai_services_name
}

output "ai_services_managed_identity_principal_id" {
  description = "AI Services managed identity principal ID (if enabled)."
  value       = module.framework-core.ai_services_managed_identity_principal_id
}

output "ai_services_private_endpoint_id" {
  description = "AI Services Private Endpoint ID (if created)."
  value       = module.framework-core.ai_services_private_endpoint_id
}

########################################
# AI Hub and Connections
########################################
output "ai_hub_id" {
  description = "AI Hub ID."
  value       = module.framework-core.ai_hub_id
}

output "ai_hub_name" {
  description = "AI Hub name."
  value       = module.framework-core.ai_hub_name
}

output "ai_hub_managed_identity_principal_id" {
  description = "AI Hub managed identity principal ID (if enabled)."
  value       = module.framework-core.ai_hub_managed_identity_principal_id
}

output "ai_hub_private_endpoint_id" {
  description = "AI Hub Private Endpoint ID (if created)."
  value       = module.framework-core.ai_hub_private_endpoint_id
}

output "ai_services_hub_connection_id" {
  description = "AI Hub connection ID for AI Services (if created)."
  value       = module.framework-core.ai_services_hub_connection_id
}

output "ai_services_hub_connection_name" {
  description = "AI Hub connection name for AI Services (if created)."
  value       = module.framework-core.ai_services_hub_connection_name
}

output "ai_search_hub_connection_id" {
  description = "AI Hub connection ID for AI Search (if created)."
  value       = module.framework-core.ai_search_hub_connection_id
}

output "ai_search_hub_connection_name" {
  description = "AI Hub connection name for AI Search (if created)."
  value       = module.framework-core.ai_search_hub_connection_name
}

output "api_key_hub_connection_id" {
  description = "AI Hub API key connection ID (if created)."
  value       = module.framework-core.api_key_hub_connection_id
}

output "api_key_hub_connection_name" {
  description = "AI Hub API key connection name (if created)."
  value       = module.framework-core.api_key_hub_connection_name
}

########################################
# Role Assignments
########################################
output "role_assignments_groups" {
  description = "Map of role assignment IDs created for AD Groups, keyed by assignment alias."
  value       = module.framework-core.role_assignments_groups
}

output "role_assignments_managed_identities" {
  description = "Map of role assignment IDs created for Managed Identities, keyed by assignment alias."
  value       = module.framework-core.role_assignments_managed_identities
}

output "role_assignments_service_principals" {
  description = "Map of role assignment IDs created for Service Principals, keyed by assignment alias."
  value       = module.framework-core.role_assignments_service_principals
}


