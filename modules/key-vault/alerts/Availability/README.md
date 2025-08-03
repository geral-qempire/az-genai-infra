---
title: 'Availability'
description: 'An overview of metric, severity, inputs, outputs and usage.'
icon: 'bell'
---

## 1. Alert
Percentage of successful requests to the Key Vault within the selected time range.

- **Metric**: `Availability` 
- **Aggregation**: Average
- **Operator**: LessThan (fires when availability drops below threshold)
- **Evaluation Frequency**: 1 minute (PT1M)
- **Time Window**: 5 minutes (PT5M)
- **Severity**: 0 (Critical)

## 2. Usage
```hcl main.tf
module "keyvault_availability_alert" {
  source = "./modules/key-vault/alerts/Availability" # update to your source

  name                = "alert-kv-availability-prod"
  resource_group_name = "rg-security-prod"
  scopes              = [module.key_vault.id]
  
  # Alert when availability drops below 95%
  threshold = 95
  
  # Optional: custom description
  description = "Critical alert for Key Vault availability"
  
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
| `scopes`              | `list(string)`| n/a     |    yes   | List of Key Vault resource IDs to monitor.                     |
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
- An existing Azure Key Vault 