locals {
  fqdn_rules = {
    for k, v in var.outbound_rules : k => v
    if lower(try(v.type, "")) == "fqdn"
  }

  private_endpoint_rules = {
    for k, v in var.outbound_rules : k => v
    if lower(try(v.type, "")) == "private-endpoint"
  }
}

resource "azurerm_machine_learning_workspace_network_outbound_rule_fqdn" "this" {
  for_each    = local.fqdn_rules
  name        = each.key
  workspace_id = var.workspace_id
  destination_fqdn = each.value.destination
}

resource "azapi_resource" "ml_outbound_rule_private_endpoint" {
  for_each                   = local.private_endpoint_rules
  type                       = "Microsoft.MachineLearningServices/workspaces/outboundRules@2025-06-01"
  name                       = each.key
  parent_id                  = var.workspace_id
  schema_validation_enabled  = false

  body = {
    properties = {
      category = "UserDefined"
      status   = "Inactive"
      type     = "PrivateEndpoint"
      destination = {
        serviceResourceId = each.value.service_resource_id
        subresourceTarget = each.value.sub_resource_target
      }
    }
  }
}


