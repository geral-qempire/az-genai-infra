resource "azapi_resource" "this" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-10-01"
  name      = "con_${var.ai_search_service_module.search_service_name}"
  parent_id = var.ai_project_id
  schema_validation_enabled = false

  body = {
    properties = {
      category = "CognitiveSearch"
      authType = "ApiKey"
      target   = "https://${var.ai_search_service_module.search_service_name}.search.windows.net"
      metadata = {
        ResourceId = var.ai_search_service_module.search_service_id
      }
      credentials = {
        key = var.ai_search_service_module.search_service_primary_key
      }
    }
  }
}


