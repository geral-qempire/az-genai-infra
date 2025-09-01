output "id" {
  value       = azurerm_mssql_database.this.id
  description = "The ID of the SQL database."
}

output "name" {
  value       = azurerm_mssql_database.this.name
  description = "The name of the SQL database."
}

output "identity_ids" {
  value       = try(azurerm_mssql_database.this.identity[0].identity_ids, null)
  description = "The list of User Assigned Identity IDs attached to the database, or null if none."
}


