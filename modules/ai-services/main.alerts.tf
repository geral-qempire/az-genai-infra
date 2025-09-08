########################################
# Alerts - Azure AI Services
########################################

locals {
  ai_services_resource_name = azurerm_ai_services.this.name
  default_avail_alert_name  = "alrt-avail-${local.ai_services_resource_name}"
  default_tok_alert_name    = "alrt-tok-${local.ai_services_resource_name}"
  default_ttft_alert_name   = "alrt-ttft-${local.ai_services_resource_name}"
  default_ttlt_alert_name   = "alrt-ttlt-${local.ai_services_resource_name}"
}

########################################
# Azure OpenAI Availability Rate Alert
########################################
resource "azurerm_monitor_metric_alert" "availability_rate" {
  count               = var.enable_availability_rate_alert ? 1 : 0
  name                = coalesce(var.availability_rate_alert_name, local.default_avail_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_ai_services.this.id]

  description = coalesce(
    var.availability_rate_alert_description,
    "Alert when AzureOpenAIAvailabilityRate (Average) over ${var.availability_rate_alert_window_size} is below ${var.availability_rate_alert_threshold}%."
  )

  severity      = var.availability_rate_alert_severity
  enabled       = var.availability_rate_alert_enabled
  auto_mitigate = var.availability_rate_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.availability_rate_alert_frequency
  window_size = var.availability_rate_alert_window_size

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = "AzureOpenAIAvailabilityRate"
    aggregation      = var.availability_rate_alert_aggregation
    operator         = var.availability_rate_alert_operator
    threshold        = var.availability_rate_alert_threshold

    dynamic "dimension" {
      for_each = [1]
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = length(var.availability_rate_alert_model_deployment_names) > 0 ? var.availability_rate_alert_model_deployment_names : ["*"]
      }
    }
  }

  dynamic "action" {
    for_each = var.availability_rate_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# Processed Inference Tokens Alert
########################################
resource "azurerm_monitor_metric_alert" "processed_tokens" {
  count               = var.enable_processed_tokens_alert ? 1 : 0
  name                = coalesce(var.processed_tokens_alert_name, local.default_tok_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_ai_services.this.id]

  description = coalesce(
    var.processed_tokens_alert_description,
    "Alert when Processed Inference Tokens (Total) over ${var.processed_tokens_alert_window_size} is above ${var.processed_tokens_alert_threshold}."
  )

  severity      = var.processed_tokens_alert_severity
  enabled       = var.processed_tokens_alert_enabled
  auto_mitigate = var.processed_tokens_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.processed_tokens_alert_frequency
  window_size = var.processed_tokens_alert_window_size

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = "TokenTransaction"
    aggregation      = var.processed_tokens_alert_aggregation
    operator         = var.processed_tokens_alert_operator
    threshold        = var.processed_tokens_alert_threshold

    dynamic "dimension" {
      for_each = [1]
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = length(var.processed_tokens_alert_model_deployment_names) > 0 ? var.processed_tokens_alert_model_deployment_names : ["*"]
      }
    }
  }

  dynamic "action" {
    for_each = var.processed_tokens_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# Time To First Token Alert
########################################
resource "azurerm_monitor_metric_alert" "ttft" {
  count               = var.enable_ttft_alert ? 1 : 0
  name                = coalesce(var.ttft_alert_name, local.default_ttft_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_ai_services.this.id]

  description = coalesce(
    var.ttft_alert_description,
    "Alert when AzureOpenAINormalizedTTFTInMS (Average) over ${var.ttft_alert_window_size} is above ${var.ttft_alert_threshold}ms."
  )

  severity      = var.ttft_alert_severity
  enabled       = var.ttft_alert_enabled
  auto_mitigate = var.ttft_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.ttft_alert_frequency
  window_size = var.ttft_alert_window_size

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = "AzureOpenAINormalizedTTFTInMS"
    aggregation      = var.ttft_alert_aggregation
    operator         = var.ttft_alert_operator
    threshold        = var.ttft_alert_threshold

    dynamic "dimension" {
      for_each = [1]
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = length(var.ttft_alert_model_deployment_names) > 0 ? var.ttft_alert_model_deployment_names : ["*"]
      }
    }
  }

  dynamic "action" {
    for_each = var.ttft_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}

########################################
# Time To Last Token Alert
########################################
resource "azurerm_monitor_metric_alert" "ttlt" {
  count               = var.enable_ttlt_alert ? 1 : 0
  name                = coalesce(var.ttlt_alert_name, local.default_ttlt_alert_name)
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_ai_services.this.id]

  description = coalesce(
    var.ttlt_alert_description,
    "Alert when AzureOpenAITTLTInMS (Average) over ${var.ttlt_alert_window_size} is above ${var.ttlt_alert_threshold}ms."
  )

  severity      = var.ttlt_alert_severity
  enabled       = var.ttlt_alert_enabled
  auto_mitigate = var.ttlt_alert_auto_mitigate
  tags          = var.tags

  frequency   = var.ttlt_alert_frequency
  window_size = var.ttlt_alert_window_size

  criteria {
    metric_namespace = "Microsoft.CognitiveServices/accounts"
    metric_name      = "AzureOpenAITTLTInMS"
    aggregation      = var.ttlt_alert_aggregation
    operator         = var.ttlt_alert_operator
    threshold        = var.ttlt_alert_threshold

    dynamic "dimension" {
      for_each = [1]
      content {
        name     = "ModelDeploymentName"
        operator = "Include"
        values   = length(var.ttlt_alert_model_deployment_names) > 0 ? var.ttlt_alert_model_deployment_names : ["*"]
      }
    }
  }

  dynamic "action" {
    for_each = var.ttlt_alert_action_group_ids
    content {
      action_group_id = action.value
    }
  }
}
