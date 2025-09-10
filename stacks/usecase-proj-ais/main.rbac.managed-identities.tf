########################################
# RBAC for Managed Identities (Simple Use Case)
########################################

locals {
  # Principal IDs
  managed_identity_principal_id_ai_services = module.ai_services.managed_identity_principal_id
  managed_identity_principal_id_ai_hub      = data.azurerm_machine_learning_workspace.framework_hub.identity[0].principal_id

  # Scope IDs
  scope_id_ai_services = module.ai_services.ai_services_id
  scope_id_rg          = azurerm_resource_group.this.id

  managed_identity_rbac = {
    # AI Hub MI → Contributor on template RG
    hub_rg_contributor = {
      principal_id         = local.managed_identity_principal_id_ai_hub
      scope_id             = local.scope_id_rg
      role_definition_name = "Contributor"
      principal_type       = "ServicePrincipal"
    }
  }
}

module "rbac_managed_identities" {
  source = "../../modules/rbac-map"

  rbac = local.managed_identity_rbac
}


