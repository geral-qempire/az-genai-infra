output "log_analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.this.id
  description = "The ID of the Log Analytics Workspace."
}

output "log_analytics_workspace_name" {
  value       = azurerm_log_analytics_workspace.this.name
  description = "The name of the Log Analytics Workspace."
}

output "log_analytics_workspace_customer_id" {
  value       = azurerm_log_analytics_workspace.this.workspace_id
  description = "The immutable Workspace (Customer) ID (GUID)."
}

output "log_analytics_workspace_primary_shared_key" {
  value       = azurerm_log_analytics_workspace.this.primary_shared_key
  description = "Primary shared key for the Workspace (used for Data Collector API)."
  sensitive   = true
}

output "log_analytics_workspace_secondary_shared_key" {
  value       = azurerm_log_analytics_workspace.this.secondary_shared_key
  description = "Secondary shared key for the Workspace (used for Data Collector API)."
  sensitive   = true
}


