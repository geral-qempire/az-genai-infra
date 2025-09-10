########################################
# RBAC for Service Principals (Simple Use Case)
########################################

locals {
  service_principal_rbac = merge(
    var.sp_cicd_id != null && var.sp_cicd_id != "" ? {
      # SP_CICD → Storage Account
      cicd_storage_blob_contrib = {
        principal_id         = var.sp_cicd_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = "Storage Blob Data Contributor"
        principal_type       = "ServicePrincipal"
      }
      cicd_storage_reader = {
        principal_id         = var.sp_cicd_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = "Reader"
        principal_type       = "ServicePrincipal"
      }
    } : {},
    var.sp_app_id != null && var.sp_app_id != "" ? {
      # SP_APP → AI Services
      app_ai_services_openai_user = {
        principal_id         = var.sp_app_id
        scope_id             = module.ai_services.ai_services_id
        role_definition_name = "Cognitive Services OpenAI User"
        principal_type       = "ServicePrincipal"
      }
      # SP_APP → Storage Account
      app_storage_blob_reader = {
        principal_id         = var.sp_app_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = "Storage Blob Data Reader"
        principal_type       = "ServicePrincipal"
      }
      app_storage_reader = {
        principal_id         = var.sp_app_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = "Reader"
        principal_type       = "ServicePrincipal"
      }
    } : {}
  )
}

module "rbac_service_principals" {
  source = "../../modules/rbac-map"

  rbac = local.service_principal_rbac
}


