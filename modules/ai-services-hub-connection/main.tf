resource "random_string" "suffix" {
  length  = 4
  lower   = true
  upper   = true
  numeric = true
  special = false
}

resource "azapi_resource" "this" {
  type                      = "Microsoft.MachineLearningServices/workspaces/connections@2025-06-01"
  name                      = "con_${var.ai_services_module.ai_services_name}-${random_string.suffix.result}"
  parent_id                 = var.parent_id
  schema_validation_enabled = false

  body = {
    properties = {
      category = "AIServices"
      authType = "ApiKey"
      # Append trailing slash to match service normalization and avoid perpetual diffs
      target = "https://${var.ai_services_module.ai_services_name}.cognitiveservices.azure.com/"
      metadata = {
        ResourceId = var.ai_services_module.ai_services_id
      }
      credentials = {
        key = var.ai_services_module.ai_services_primary_key
      }
    }
  }

  # Give Azure time to settle the ETag for this connection before destroy
  provisioner "local-exec" {
    when    = destroy
    command = "sleep 60"
  }
}


