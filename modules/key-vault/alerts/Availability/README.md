---
title: 'Availability'
description: 'Vault requests availability'
icon: 'bell'
---

## 1. Alert
Vault requests availability.

- **Metric**: `Availability`
- **Namespace**: `Microsoft.KeyVault/vaults`
- **Aggregation**: Average
- **Operator**: LessThan (fires when availability drops below threshold)
- **Evaluation Frequency**: 1 minute (PT1M)
- **Time Window**: 5 minutes (PT5M)
- **Severity**: 1
- **Auto Mitigate**: false

## 2. Usage
```hcl main.tf
module "kv_availability_alert" {
  source = "./modules/key-vault/alerts/Availability" # update to your source

  name                = "alert-kv-availability-prod"
  resource_group_name = "rg-observability-prod"
  scopes              = [module.key_vault.id]

  # Default threshold is 90%
  # threshold = 90

  # Optional: custom description
  description = "Key Vault availability below 90% over 5 minutes"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = [
    "/subscriptions/xxx/resourceGroups/rg-alerts/providers/Microsoft.Insights/actionGroups/ag-critical"
  ]
}
```

## 3. Inputs
| Name                  | Type           | Default | Required | Description                                                     |
| --------------------- | -------------- | ------- | :------: | --------------------------------------------------------------- |
| `name`                | `string`       | n/a     |   yes    | Name of the metric alert.                                      |
| `resource_group_name` | `string`       | n/a     |   yes    | Resource group in which to create the alert.                   |
| `scopes`              | `list(string)` | n/a     |   yes    | List of Key Vault resource IDs to monitor.                     |
| `threshold`           | `number`       | `90`    |    no    | Availability threshold percentage. Alert fires when below this value. |
| `description`         | `string`       | `null`  |    no    | Custom description for the alert. Auto-generated if not provided. |
| `enabled`             | `bool`         | `true`  |    no    | Whether the alert is enabled.                                  |
| `action_group_ids`    | `list(string)` | `[]`    |    no    | Action Group IDs to notify when the alert fires.               |

## 4. Outputs
| Name   | Description                     |
| ------ | -------------------------------- |
| `id`   | Resource ID of the metric alert. |
| `name` | Name of the metric alert.        |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group
- An existing Azure Key Vault


