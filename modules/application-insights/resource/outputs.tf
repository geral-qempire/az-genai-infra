output "id" {
  description = "The resource ID of the Application Insights."
  value       = azurerm_application_insights.this.id
}

output "name" {
  description = "The name of the Application Insights."
  value       = azurerm_application_insights.this.name
}

output "location" {
  description = "The location of the Application Insights."
  value       = azurerm_application_insights.this.location
}

output "application_type" {
  description = "The application type."
  value       = azurerm_application_insights.this.application_type
}

output "app_id" {
  description = "The App ID associated with this Application Insights component."
  value       = azurerm_application_insights.this.app_id
}

output "instrumentation_key" {
  description = "Instrumentation Key for this Application Insights component."
  value       = azurerm_application_insights.this.instrumentation_key
}

output "connection_string" {
  description = "Connection string for SDKs."
  value       = azurerm_application_insights.this.connection_string
}

output "daily_data_cap_in_gb" {
  description = "The daily data cap (GB) applied to this instance."
  value       = azurerm_application_insights.this.daily_data_cap_in_gb
}

output "retention_in_days" {
  description = "The retention (days) configured on this instance."
  value       = azurerm_application_insights.this.retention_in_days
}

output "sampling_percentage" {
  description = "The sampling percentage configured on this instance."
  value       = azurerm_application_insights.this.sampling_percentage
}
