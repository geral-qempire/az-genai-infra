output "application_insights_id" {
  value       = azurerm_application_insights.this.id
  description = "The ID of the Application Insights resource."
}

output "application_insights_name" {
  value       = azurerm_application_insights.this.name
  description = "The name of the Application Insights resource."
}

output "instrumentation_key" {
  value       = azurerm_application_insights.this.instrumentation_key
  description = "Instrumentation Key for classic ingestion."
}

output "connection_string" {
  value       = azurerm_application_insights.this.connection_string
  description = "Connection string for Application Insights."
}


