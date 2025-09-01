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
  managed_identity_principal_id_ai_project  = module.ai_project.managed_identity_principal_id

  # Scope IDs
  scope_id_ai_services = module.ai_services.ai_services_id
  scope_id_ai_search   = data.azurerm_search_service.framework_search.id
  scope_id_rg          = azurerm_resource_group.this.id
  scope_id_storage     = module.storage_account.storage_account_id
  scope_id_pe_blob     = module.storage_account.private_endpoint_blob_id
  scope_id_pe_file     = module.storage_account.private_endpoint_file_id

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

    # Loaded AI Search MI → roles on Storage
    search_to_storage_blob_contrib = {
      principal_id         = local.managed_identity_principal_id_ai_search
      scope_id             = local.scope_id_storage
      role_definition_name = "Storage Blob Data Contributor"
      principal_type       = "ServicePrincipal"
    }

    # AI Project MI → Reader on Storage PEs
    project_pe_blob_reader = {
      principal_id         = local.managed_identity_principal_id_ai_project
      scope_id             = local.scope_id_pe_blob
      role_definition_name = "Reader"
      principal_type       = "ServicePrincipal"
    }
    project_pe_file_reader = {
      principal_id         = local.managed_identity_principal_id_ai_project
      scope_id             = local.scope_id_pe_file
      role_definition_name = "Reader"
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


