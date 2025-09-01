output "outbound_rule_ids" {
  description = "Map of outbound rule resource IDs keyed by rule name."
  value = merge(
    { for k, r in azurerm_machine_learning_workspace_network_outbound_rule_fqdn.this : k => r.id },
    { for k, r in azapi_resource.ml_outbound_rule_private_endpoint : k => r.id }
  )
}


