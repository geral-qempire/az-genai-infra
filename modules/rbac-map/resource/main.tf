resource "azurerm_role_assignment" "this" {
  for_each                         = var.rbac
  scope                            = each.value.scope_id
  role_definition_id               = try(each.value.role_definition_id, null)
  role_definition_name             = try(each.value.role_definition_name, null)
  principal_id                     = each.value.principal_id
  principal_type                   = try(each.value.principal_type, null)
  skip_service_principal_aad_check = true
}


