resource "random_string" "suffix" {
  length  = 4
  lower   = true
  upper   = true
  numeric = true
  special = false
}

resource "azapi_resource" "this" {
  type      = "Microsoft.MachineLearningServices/workspaces/connections@2024-10-01"
  name      = "con_${var.ai_search_service_module.search_service_name}-${random_string.suffix.result}"
  parent_id = var.parent_id
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

  lifecycle {
    create_before_destroy = false
    ignore_changes = [
      body.properties.metadata,
      body.properties.credentials
    ]
  }

  # Enhanced destroy provisioner
  provisioner "local-exec" {
    when    = destroy
    command = "sleep 90"
  }
}


