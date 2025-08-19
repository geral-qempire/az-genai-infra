resource "azapi_resource" "this" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2025-06-01"
  name      = var.connection_name
  parent_id = var.ai_project_id
  schema_validation_enabled = false

  body = {
    properties = {
      category = "ApiKey"
      authType = "ApiKey"
      target   = var.target_url
      metadata = var.metadata
      credentials = {
        key = var.api_key
      }
    }
  }
}


