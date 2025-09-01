output "id" {
  value       = azurerm_mssql_server.this.id
  description = "The ID of the SQL Server."
}

output "name" {
  value       = azurerm_mssql_server.this.name
  description = "The name of the SQL Server."
}

output "fully_qualified_domain_name" {
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
  description = "The FQDN of the SQL Server."
}

output "principal_id" {
  value       = try(azurerm_mssql_server.this.identity[0].principal_id, null)
  description = "The Principal ID associated with the Managed Service Identity of this SQL Server, if any."
}

output "private_endpoint_id" {
  value       = try(azurerm_private_endpoint.this[0].id, null)
  description = "The ID of the Private Endpoint if created, otherwise null."
}


