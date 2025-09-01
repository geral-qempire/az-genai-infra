output "action_group_id" {
  description = "Resource ID of the action group."
  value       = azurerm_monitor_action_group.this.id
}

output "action_group_name" {
  description = "Name of the action group."
  value       = azurerm_monitor_action_group.this.name
}
