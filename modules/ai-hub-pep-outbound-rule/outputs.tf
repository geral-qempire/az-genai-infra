output "outbound_rule_id" {
  value       = azapi_resource.this.id
  description = "The resource ID of the outbound rule."
}

output "outbound_rule_name" {
  value       = azapi_resource.this.name
  description = "The name of the outbound rule."
}


