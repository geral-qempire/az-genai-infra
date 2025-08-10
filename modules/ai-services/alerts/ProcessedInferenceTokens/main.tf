locals {
  ai_services_resource_name = try(
    element(split("/", var.scopes[0]), length(split("/", var.scopes[0])) - 1),
    "resource"
  )
  default_name = "alrt-tok-${local.ai_services_resource_name}"
}

resource "azurerm_monitor_metric_alert" "this" {
  name                = coalesce(var.name, local.default_name)
  resource_group_name = var.resource_group_name
  scopes              = var.scopes

  description = coalesce(
    var.description,
    "Alert when Processed Inference Tokens (Total) over PT1H is above ${var.threshold}."
  )

  severity      = 3
  enabled       = var.enabled
  auto_mitigate = false

  frequency   = "PT1H"
  window_size = "PT1H"

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = var.metric_name
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.threshold

    dynamic "dimension" {
      for_each = length(var.model_deployment_names) > 0 ? [1] : []
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = var.model_deployment_names
      }
    }
  }

  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id = action.value
    }
  }
}


