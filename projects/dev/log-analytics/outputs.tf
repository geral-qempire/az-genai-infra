output "resource_group_name" {
  description = "Name of the log analytics resource group."
  value       = module.log_analytics.resource_group_name
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace."
  value       = module.log_analytics.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  value       = module.log_analytics.log_analytics_workspace_name
}

output "log_analytics_workspace_customer_id" {
  description = "Immutable Workspace (Customer) ID (GUID)."
  value       = module.log_analytics.log_analytics_workspace_customer_id
}
