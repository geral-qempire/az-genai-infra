resource "azapi_resource" "this" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2025-06-01"
  name      = "con_${var.ai_services_module.ai_services_name}"
  parent_id = var.ai_project_id
  schema_validation_enabled = false

  body = {
    properties = {
      category = "AIServices"
      authType = "ApiKey"
      target   = "https://${var.ai_services_module.ai_services_name}.cognitiveservices.azure.com"
      metadata = {
        ResourceId = var.ai_services_module.ai_services_id
      }
      credentials = {
        key = var.ai_services_module.ai_services_primary_key
      }
    }
  }
}


