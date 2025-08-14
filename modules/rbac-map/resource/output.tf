output "role_assignment_ids" {
  description = "Map of role assignment resource IDs keyed by the RBAC map key"
  value       = { for k, v in azurerm_role_assignment.this : k => v.id }
}


