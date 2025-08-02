---
title: 'Availability'
description: 'An overview of metric, severity, inputs, outputs and usage.'
icon: 'bell'
---

## 1. Alert
Percentage of successful user queries in the Log Analytics workspace within the selected time range.

- **Metric**: `AvailabilityRate_Query` 
- **Aggregation**: Average
- **Operator**: LessThan (fires when availability drops below threshold)
- **Evaluation Frequency**: 1 minutes (PT5M)
- **Time Window**: 5 minutes (PT5M)
- **Severity**: 1 (Error)

## 2. Usage
```hcl main.tf
module "availability_alert" {
  source = "./modules/log-analytics-workspace/alerts/AvailabilityRate_Query" # update to your source

  name                = "alert-law-availability-prod"
  resource_group_name = "rg-observability-prod"
  scopes              = [module.log_analytics_workspace.id]
  
  # Alert when availability drops below 95%
  threshold = 95
  
  # Optional: custom description
  description = "Critical alert for Log Analytics workspace availability"
  
  # Optional: enable/disable the alert
  enabled = true
  
  # Optional: notify action groups when alert fires
  action_group_ids = [
    "/subscriptions/xxx/resourceGroups/rg-alerts/providers/Microsoft.Insights/actionGroups/ag-critical"
  ]
}
```

## 3. Inputs
| Name                  | Type          | Default | Required | Description                                                     |
| --------------------- | ------------- | ------- | :------: | --------------------------------------------------------------- |
| `name`                | `string`      | n/a     |    yes   | Name of the metric alert.                                       |
| `resource_group_name` | `string`      | n/a     |    yes   | Resource group in which to create the alert.                   |
| `scopes`              | `list(string)`| n/a     |    yes   | List of Log Analytics workspace resource IDs to monitor.       |
| `threshold`           | `number`      | n/a     |    yes   | Percentage threshold (0-100). Alert fires when availability is below this value. |
| `description`         | `string`      | `null`  |    no    | Custom description for the alert. Auto-generated if not provided. |
| `enabled`             | `bool`        | `true`  |    no    | Whether the alert is enabled.                                  |
| `action_group_ids`    | `list(string)`| `[]`    |    no    | Action Group IDs to notify when the alert fires.              |

## 4. Outputs
| Name   | Description                   |
| ------ | ----------------------------- |
| `id`   | Resource ID of the metric alert. |
| `name` | Name of the metric alert.    |


## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group