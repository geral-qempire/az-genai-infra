locals {
  resource_name_tail = element(split("/", var.service_resource_id), length(split("/", var.service_resource_id)) - 1)
  computed_name       = var.name != null && var.name != "" ? var.name : lower("pep-${var.sub_resource_target}-${local.resource_name_tail}")
}

resource "terraform_data" "replace_on_change" {
  # Any change here will force a replacement of the azapi resource below
  triggers_replace = {
    name                = local.computed_name
    parent_id           = var.parent_id
    service_resource_id = var.service_resource_id
    sub_resource_target = var.sub_resource_target
    spark_enabled       = tostring(var.spark_enabled)
  }
}

resource "azapi_resource" "this" {
  type                      = "Microsoft.MachineLearningServices/workspaces/outboundRules@2023-04-01"
  name                      = local.computed_name
  parent_id                 = var.parent_id
  schema_validation_enabled = false
  locks                     = [var.parent_id]

  body = {
    properties = {
      type     = "PrivateEndpoint"
      category = "UserDefined"
      destination = {
        serviceResourceId = var.service_resource_id
        subresourceTarget = var.sub_resource_target
        sparkEnabled      = var.spark_enabled
      }
    }
  }

  lifecycle {
    # Destroy first (same name), then recreate. Replacement triggered by terraform_data above.
    create_before_destroy = false
    replace_triggered_by  = [terraform_data.replace_on_change]
  }

  # Short delay to allow ARM propagation before subsequent dependent operations
  provisioner "local-exec" {
    when    = create
    command = "sleep 20"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "sleep 20"
  }
}


