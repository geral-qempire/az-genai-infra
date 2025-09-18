resource "terraform_data" "replace_on_change" {
  triggers_replace = {
    name          = var.name
    parent_id     = var.parent_id
    fqdn          = var.fqdn
    spark_enabled = tostring(var.spark_enabled)
  }
}

resource "azapi_resource" "this" {
  type                      = "Microsoft.MachineLearningServices/workspaces/outboundRules@2023-04-01"
  name                      = var.name
  parent_id                 = var.parent_id
  schema_validation_enabled = false
  locks                     = [var.parent_id]

  body = {
    properties = {
      type     = "FQDN"
      category = "UserDefined"
      destination = var.fqdn
      sparkEnabled = var.spark_enabled
    }
  }

  lifecycle {
    create_before_destroy = false
    replace_triggered_by  = [terraform_data.replace_on_change]
  }

  provisioner "local-exec" {
    when    = create
    command = "sleep 20"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "sleep 20"
  }
}


