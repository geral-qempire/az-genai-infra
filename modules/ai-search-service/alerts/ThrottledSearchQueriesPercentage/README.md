---
title: 'ThrottledSearchQueriesPercentage'
description: 'Percentage of search queries that were throttled for the search service.'
icon: 'bell'
---

## 1. Alert
Percentage of search queries that were throttled for the search service.

- **Metric**: `ThrottledSearchQueriesPercentage`
- **Namespace**: `Microsoft.Search/searchServices`
- **Aggregation**: Average
- **Operator**: GreaterThan (fires when percentage exceeds threshold)
- **Evaluation Frequency**: 1 minute (PT1M)
- **Time Window**: 5 minutes (PT5M)
- **Severity**: 3

## 2. Usage
```hcl main.tf
module "throttled_search_pct_alert" {
  source = "./modules/ai-search-service/alerts/ThrottledSearchQueriesPercentage" # update to your source

  name                = "alert-throttled-search-pct-prod"
  resource_group_name = "rg-observability-prod"
  scopes              = [module.ai_search_service.search_service_id]

  # Alert when throttled search queries exceed 10% over 5 minutes
  threshold = 10

  # Optional: custom description
  description = "Average throttled search queries percentage over 5 minutes above 10%"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = [
    "/subscriptions/xxx/resourceGroups/rg-alerts/providers/Microsoft.Insights/actionGroups/ag-warning"
  ]
}
```

## 3. Inputs
| Name                  | Type           | Default | Required | Description                                                     |
| --------------------- | -------------- | ------- | :------: | --------------------------------------------------------------- |
| `name`                | `string`       | n/a     |   yes    | Name of the metric alert.                                      |
| `resource_group_name` | `string`       | n/a     |   yes    | Resource group in which to create the alert.                   |
| `scopes`              | `list(string)` | n/a     |   yes    | List of Search Service resource IDs to monitor.                |
| `threshold`           | `number`       | `10`    |    no    | Percentage threshold. Alert fires when above this value.       |
| `description`         | `string`       | `null`  |    no    | Custom description for the alert. Auto-generated if not provided. |
| `enabled`             | `bool`         | `true`  |    no    | Whether the alert is enabled.                                  |
| `action_group_ids`    | `list(string)` | `[]`    |    no    | Action Group IDs to notify when the alert fires.               |

## 4. Outputs
| Name   | Description                     |
| ------ | -------------------------------- |
| `id`   | Resource ID of the metric alert. |
| `name` | Name of the metric alert.        |

## 5. Requirements
- Terraform `>= 1.12.1, < 2.0.0`
- AzureRM provider `~> 4.38`
- An existing Azure Resource Group
- An existing Azure AI Search Service
  
Note: This module does not require the `azurerm.dns` provider alias.


