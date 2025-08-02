# Azure Monitor Metric Alert - AvailabilityRate_Query (Terraform Module)

Enterprise-ready Terraform module to create an Azure Monitor Metric Alert for Log Analytics workspace availability monitoring.  
This module monitors the **AvailabilityRate_Query** metric to track user query success rate and fires alerts when availability drops below a specified threshold.

## Features
- Monitors Log Analytics workspace user query success rate
- Fixed enterprise policy settings: `severity = 1`, `frequency = PT5M`, `window_size = PT1H`
- Configurable availability threshold (0-100%)
- Optional Action Group integration for notifications
- Automatic fallback description if none provided
- Supports multiple workspace scopes

## Usage

```hcl
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

## Inputs

| Name                  | Type          | Default | Required | Description                                                     |
| --------------------- | ------------- | ------- | :------: | --------------------------------------------------------------- |
| `name`                | `string`      | n/a     |    yes   | Name of the metric alert.                                       |
| `resource_group_name` | `string`      | n/a     |    yes   | Resource group in which to create the alert.                   |
| `scopes`              | `list(string)`| n/a     |    yes   | List of Log Analytics workspace resource IDs to monitor.       |
| `threshold`           | `number`      | n/a     |    yes   | Percentage threshold (0-100). Alert fires when availability is below this value. |
| `description`         | `string`      | `null`  |    no    | Custom description for the alert. Auto-generated if not provided. |
| `enabled`             | `bool`        | `true`  |    no    | Whether the alert is enabled.                                  |
| `action_group_ids`    | `list(string)`| `[]`    |    no    | Action Group IDs to notify when the alert fires.              |

**Note:** This alert uses the `AvailabilityRate_Query` metric with `Average` aggregation over a 1-hour window, evaluated every 5 minutes.

## Outputs

| Name   | Description                   |
| ------ | ----------------------------- |
| `id`   | Resource ID of the metric alert. |
| `name` | Name of the metric alert.    |

## Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group
- One or more Log Analytics workspaces to monitor

## Alert Details
- **Metric**: `AvailabilityRate_Query` (Microsoft.OperationalInsights/workspaces)
- **Aggregation**: Average
- **Operator**: LessThan (fires when availability drops below threshold)
- **Evaluation Frequency**: 5 minutes (PT5M)
- **Time Window**: 1 hour (PT1H)
- **Severity**: 1 (Critical - fixed by enterprise policy) 