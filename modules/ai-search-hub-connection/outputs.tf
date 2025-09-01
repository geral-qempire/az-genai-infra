output "connection_name" {
  value       = azapi_resource.this.name
  description = "The name of the created connection."
}

output "connection_id" {
  value       = azapi_resource.this.id
  description = "The resource ID of the created connection."
}


