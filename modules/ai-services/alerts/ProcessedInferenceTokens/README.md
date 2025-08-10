---
title: 'ProcessedInferenceTokens'
description: 'Azure OpenAI processed inference tokens (total) split by model deployment'
icon: 'bell'
---

## 1. Alert
Azure OpenAI processed inference tokens by model deployment.

- **Metric**: `TokenTransaction` (Processed Inference Tokens)
- **Namespace**: `Microsoft.CognitiveServices/accounts`
- **Aggregation**: Total
- **Operator**: GreaterThan (fires when total tokens exceed threshold)
- **Evaluation Frequency**: 24 hours (P1D)
- **Time Window**: 24 hours (P1D)
- **Severity**: 3
- **Auto Mitigate**: false

## 2. Usage
```hcl main.tf
module "ai_processed_inference_tokens_alert" {
  source = "./modules/ai-services/alerts/ProcessedInferenceTokens" # update to your source

  name                = "alrt-tok-openai-prod"
  resource_group_name = "rg-observability-prod"
  scopes              = [module.ai_services.id] # Microsoft.CognitiveServices/accounts

  # Default threshold is 10,000,000 tokens
  # threshold = 10000000

  # Split by model deployment name(s)
  model_deployment_names = [
    "gpt-4o-mini",
    "text-embedding-3-large"
  ]

  # Optional: custom description
  description = "Azure OpenAI processed tokens exceeded threshold over the last 24 hours"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = [
    "/subscriptions/xxx/resourceGroups/rg-alerts/providers/Microsoft.Insights/actionGroups/ag-critical"
  ]
}
```

## 3. Inputs
| Name                     | Type           | Default   | Required | Description |
|--------------------------|----------------|-----------|:--------:|-------------|
| `name`                   | `string`       | `null`    |    no    | Name of the metric alert. |
| `resource_group_name`    | `string`       | n/a       |   yes    | Resource group in which to create the alert. |
| `scopes`                 | `list(string)` | n/a       |   yes    | List of Azure AI Services account resource IDs (Microsoft.CognitiveServices/accounts). |
| `threshold`              | `number`       | `10000000` |    no   | Token threshold. Fires when total tokens over the window exceed this value. |
| `model_deployment_names` | `list(string)` | n/a       |   yes    | Model deployment names to filter on `ModelDeploymentName` dimension. |
| `description`            | `string`       | `null`    |    no    | Custom description for the alert. |
| `enabled`                | `bool`         | `true`    |    no    | Whether the alert is enabled. |
| `action_group_ids`       | `list(string)` | `[]`      |    no    | Action Group IDs to notify when the alert fires. |
| `metric_name`            | `string`       | `TokenTransaction` |  no | Advanced: override the metric name if needed. |

## 4. Outputs
| Name   | Description                     |
|--------|---------------------------------|
| `id`   | Resource ID of the metric alert. |
| `name` | Name of the metric alert.        |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group
- An existing Azure AI Services (Cognitive Services) account with Azure OpenAI enabled


