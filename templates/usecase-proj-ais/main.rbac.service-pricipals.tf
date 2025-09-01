########################################
# RBAC for Service Principals (Simple Use Case)
########################################

locals {
  service_principal_rbac = merge(
    var.sp_app_id != null && var.sp_app_id != "" ? {
      # SP_APP → AI Services
      app_ai_services_openai_user = {
        principal_id         = var.sp_app_id
        scope_id             = module.ai_services.ai_services_id
        role_definition_name = "Cognitive Services OpenAI User"
        principal_type       = "ServicePrincipal"
      }
    } : {}
  )
}

module "rbac_service_principals" {
  source = "../../modules/rbac-map"

  rbac = local.service_principal_rbac
}


