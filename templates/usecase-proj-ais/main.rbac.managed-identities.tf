########################################
# RBAC for Managed Identities (Simple Use Case)
########################################

# Lookup loaded AI Search (from framework) using azurerm
data "azurerm_search_service" "framework_search" {
  name                = var.framework_ai_search_name
  resource_group_name = data.azurerm_resource_group.framework.name
}

locals {
  # Principal IDs
  managed_identity_principal_id_ai_services = module.ai_services.managed_identity_principal_id
  managed_identity_principal_id_ai_search   = data.azurerm_search_service.framework_search.identity[0].principal_id
  managed_identity_principal_id_ai_hub      = data.azurerm_machine_learning_workspace.framework_hub.identity[0].principal_id

  # Scope IDs
  scope_id_ai_services = module.ai_services.ai_services_id
  scope_id_ai_search   = data.azurerm_search_service.framework_search.id
  scope_id_rg          = azurerm_resource_group.this.id

  managed_identity_rbac = {
    # AI Services MI → roles on loaded AI Search
    ai_services_to_search_idx_contrib = {
      principal_id         = local.managed_identity_principal_id_ai_services
      scope_id             = local.scope_id_ai_search
      role_definition_name = "Search Index Data Contributor"
      principal_type       = "ServicePrincipal"
    }
    ai_services_to_search_idx_reader = {
      principal_id         = local.managed_identity_principal_id_ai_services
      scope_id             = local.scope_id_ai_search
      role_definition_name = "Search Index Data Reader"
      principal_type       = "ServicePrincipal"
    }
    ai_services_to_search_service_contrib = {
      principal_id         = local.managed_identity_principal_id_ai_services
      scope_id             = local.scope_id_ai_search
      role_definition_name = "Search Service Contributor"
      principal_type       = "ServicePrincipal"
    }

    # Loaded AI Search MI → roles on AI Services
    search_to_ai_services_contrib = {
      principal_id         = local.managed_identity_principal_id_ai_search
      scope_id             = local.scope_id_ai_services
      role_definition_name = "Cognitive Services Contributor"
      principal_type       = "ServicePrincipal"
    }
    search_to_ai_services_openai_contrib = {
      principal_id         = local.managed_identity_principal_id_ai_search
      scope_id             = local.scope_id_ai_services
      role_definition_name = "Cognitive Services OpenAI Contributor"
      principal_type       = "ServicePrincipal"
    }

    # Loaded AI Hub MI → Contributor on template RG
    hub_rg_contributor = {
      principal_id         = local.managed_identity_principal_id_ai_hub
      scope_id             = local.scope_id_rg
      role_definition_name = "Contributor"
      principal_type       = "ServicePrincipal"
    }
  }
}

module "rbac_managed_identities" {
  source = "../../modules/rbac-map/resource"

  rbac = local.managed_identity_rbac
}


