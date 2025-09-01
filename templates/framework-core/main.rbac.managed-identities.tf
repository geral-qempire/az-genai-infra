########################################
# RBAC for Managed Identities
########################################

locals {
  managed_identity_rbac = {
    # Azure AI Search → roles for Azure AI Services MI
    ai_search_idx_contrib = {
      principal_id         = module.ai_services.managed_identity_principal_id
      scope_id             = module.ai_search_service.search_service_id
      role_definition_name = "Search Index Data Contributor"
      principal_type       = "ServicePrincipal"
    }
    ai_search_idx_reader = {
      principal_id         = module.ai_services.managed_identity_principal_id
      scope_id             = module.ai_search_service.search_service_id
      role_definition_name = "Search Index Data Reader"
      principal_type       = "ServicePrincipal"
    }
    ai_search_service_contrib = {
      principal_id         = module.ai_services.managed_identity_principal_id
      scope_id             = module.ai_search_service.search_service_id
      role_definition_name = "Search Service Contributor"
      principal_type       = "ServicePrincipal"
    }

    # Azure AI Services → roles for Azure AI Search MI
    ai_services_contrib = {
      principal_id         = module.ai_search_service.managed_identity_principal_id
      scope_id             = module.ai_services.ai_services_id
      role_definition_name = "Cognitive Services Contributor"
      principal_type       = "ServicePrincipal"
    }
    ai_services_openai_contrib = {
      principal_id         = module.ai_search_service.managed_identity_principal_id
      scope_id             = module.ai_services.ai_services_id
      role_definition_name = "Cognitive Services OpenAI Contributor"
      principal_type       = "ServicePrincipal"
    }

    # Storage Account → role for Azure AI Search MI
    storage_blob_contrib = {
      principal_id         = module.ai_search_service.managed_identity_principal_id
      scope_id             = module.storage_account.storage_account_id
      role_definition_name = "Storage Blob Data Contributor"
      principal_type       = "ServicePrincipal"
    }

    # Azure AI Project → roles on Storage (PEs)
    proj_pe_blob_reader = {
      principal_id         = module.ai_project.managed_identity_principal_id
      scope_id             = module.storage_account.private_endpoint_blob_id
      role_definition_name = "Reader"
      principal_type       = "ServicePrincipal"
    }
    proj_pe_file_reader = {
      principal_id         = module.ai_project.managed_identity_principal_id
      scope_id             = module.storage_account.private_endpoint_file_id
      role_definition_name = "Reader"
      principal_type       = "ServicePrincipal"
    }

    # Resource Group → role for Azure AI Hub MI
    rg_contributor = {
      principal_id         = module.ai_hub.managed_identity_principal_id
      scope_id             = azurerm_resource_group.this.id
      role_definition_name = "Contributor"
      principal_type       = "ServicePrincipal"
    }
  }
}

module "rbac_managed_identities" {
  source = "../../modules/rbac-map/resource"

  rbac = local.managed_identity_rbac
}


