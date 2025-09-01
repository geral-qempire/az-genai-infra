---
title: 'SaturationShoebox'
description: 'Vault capacity used'
icon: 'bell'
---

## 1. Alert
Vault capacity used.

- **Metric**: `SaturationShoebox`
- **Namespace**: `Microsoft.KeyVault/vaults`
- **Aggregation**: Average
- **Operator**: GreaterThan (fires when capacity used exceeds threshold)
- **Evaluation Frequency**: 1 minute (PT1M)
- **Time Window**: 5 minutes (PT5M)
- **Severity**: 1
- **Auto Mitigate**: false

## 2. Usage
```hcl main.tf
module "kv_saturation_alert" {
  source = "./modules/key-vault/alerts/SaturationShoebox" # update to your source

  name                = "alert-kv-saturation-prod"
  resource_group_name = "rg-observability-prod"
  scopes              = [module.key_vault.id]

  # Default threshold is 75%
  # threshold = 75

  # Optional: custom description
  description = "Key Vault capacity used above 75% over 5 minutes"

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
| `threshold`           | `number`       | `75`    |    no    | Used capacity threshold percentage. Alert fires when above this value. |
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
- An existing Azure Key Vault


