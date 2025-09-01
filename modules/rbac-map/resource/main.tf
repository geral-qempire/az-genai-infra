resource "azurerm_role_assignment" "this" {
  for_each                         = var.rbac
  scope                            = each.value.scope_id
  role_definition_id               = each.value.role_definition_id
  role_definition_name             = each.value.role_definition_name
  principal_id                     = each.value.principal_id
  principal_type                   = each.value.principal_type
  skip_service_principal_aad_check = true
  lifecycle {
    ignore_changes = [
      principal_type,
      role_definition_id,
      role_definition_name,
    ]
  }
}


