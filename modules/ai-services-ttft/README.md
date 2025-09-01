---
title: 'AzureOpenAINormalizedTTFTInMS'
description: 'Azure OpenAI normalized time-to-first-token (ms) split by model deployment'
icon: 'bell'
---

## 1. Alert
Azure OpenAI normalized time-to-first-token (ms) by model deployment.

- **Metric**: `AzureOpenAINormalizedTTFTInMS`
- **Namespace**: `Microsoft.CognitiveServices/accounts`
- **Aggregation**: Average
- **Operator**: GreaterThan (fires when TTFT rises above threshold)
- **Evaluation Frequency**: 1 minute (PT1M)
- **Time Window**: 5 minutes (PT5M)
- **Severity**: 2
- **Auto Mitigate**: false

## 2. Usage
```hcl main.tf
module "ai_azureopenai_ttft_alert" {
  source = "./modules/ai-services-ttft" # update to your source

  name                = "alrt-ttft-openai-prod"
  resource_group_name = "rg-observability-prod"
  scopes              = [module.ai_services.id] # Microsoft.CognitiveServices/accounts

  # Default threshold is 5 ms (override as needed for your workload)
  # threshold = 200

  # Split by model deployment name(s)
  model_deployment_names = [
    "gpt-4o-mini",
    "text-embedding-3-large"
  ]

  # Optional: custom description
  description = "Azure OpenAI TTFT above threshold over 5 minutes"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = [
    "/subscriptions/xxx/resourceGroups/rg-alerts/providers/Microsoft.Insights/actionGroups/ag-critical"
  ]
}
```

## 3. Inputs
| Name                     | Type           | Default | Required | Description |
|--------------------------|----------------|---------|:--------:|-------------|
| `name`                   | `string`       | `null`  |    no    | Name of the metric alert. |
| `resource_group_name`    | `string`       | n/a     |   yes    | Resource group in which to create the alert. |
| `scopes`                 | `list(string)` | n/a     |   yes    | List of Azure AI Services account resource IDs (Microsoft.CognitiveServices/accounts). |
| `threshold`              | `number`       | `5`     |    no    | TTFT threshold in milliseconds. Fires when above this value. |
| `model_deployment_names` | `list(string)` | n/a     |   yes    | Model deployment names to filter on `ModelDeploymentName` dimension. |
| `description`            | `string`       | `null`  |    no    | Custom description for the alert. |
| `enabled`                | `bool`         | `true`  |    no    | Whether the alert is enabled. |
| `action_group_ids`       | `list(string)` | `[]`    |    no    | Action Group IDs to notify when the alert fires. |

## 4. Outputs
| Name   | Description                     |
|--------|---------------------------------|
| `id`   | Resource ID of the metric alert. |
| `name` | Name of the metric alert.        |

## 5. Requirements
- Terraform `>= 1.12.1, < 2.0.0`
- AzureRM provider `~> 4.38`
- An existing Azure Resource Group
- An existing Azure AI Services (Cognitive Services) account with Azure OpenAI enabled


