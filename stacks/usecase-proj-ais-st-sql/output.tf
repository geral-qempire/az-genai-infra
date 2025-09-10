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

########################################
# Alert Outputs
########################################
output "ai_services_alert_ids" {
  description = "Map of AI Services alert IDs."
  value = {
    availability_rate = module.ai_services.availability_rate_alert_id
    processed_tokens  = module.ai_services.processed_tokens_alert_id
    ttft             = module.ai_services.ttft_alert_id
    ttlt             = module.ai_services.ttlt_alert_id
  }
}

output "storage_account_alert_ids" {
  description = "Map of Storage Account alert IDs."
  value = {
    availability           = module.storage_account.availability_alert_id
    success_server_latency = module.storage_account.success_server_latency_alert_id
    used_capacity         = module.storage_account.used_capacity_alert_id
  }
}

output "sql_database_alert_ids" {
  description = "Map of SQL Database alert IDs."
  value = {
    availability        = module.sql_database.availability_alert_id
    storage            = module.sql_database.storage_alert_id
    app_cpu            = module.sql_database.app_cpu_alert_id
    app_memory         = module.sql_database.app_memory_alert_id
    sql_instance_cpu   = module.sql_database.sql_instance_cpu_alert_id
    sql_instance_memory = module.sql_database.sql_instance_memory_alert_id
  }
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


