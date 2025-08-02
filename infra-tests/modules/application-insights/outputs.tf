output "resource_group_name" {
  description = "Name of the test resource group."
  value       = azurerm_resource_group.test.name
}

output "application_insights_id" {
  description = "Azure resource ID of the Application Insights."
  value       = module.application_insights.id
}

output "application_insights_name" {
  description = "Name of the Application Insights."
  value       = module.application_insights.name
}

output "app_id" {
  description = "App ID associated with this Application Insights component."
  value       = module.application_insights.app_id
}

output "instrumentation_key" {
  description = "Instrumentation Key for this Application Insights component."
  value       = module.application_insights.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "Connection string for SDKs."
  value       = module.application_insights.connection_string
  sensitive   = true
}

output "application_type" {
  description = "The application type configured."
  value       = module.application_insights.application_type
}

output "retention_in_days" {
  description = "The retention (days) configured."
  value       = module.application_insights.retention_in_days
}

output "sampling_percentage" {
  description = "The sampling percentage configured."
  value       = module.application_insights.sampling_percentage
}

output "daily_data_cap_in_gb" {
  description = "The daily data cap (GB) applied."
  value       = module.application_insights.daily_data_cap_in_gb
} 