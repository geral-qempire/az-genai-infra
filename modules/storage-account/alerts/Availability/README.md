---
title: 'Availability'
description: 'Storage Account requests availability'
icon: 'bell'
---

## 1. Alert
Storage Account requests availability.

- **Metric**: `Availability`
- **Namespace**: `Microsoft.Storage/storageAccounts`
- **Aggregation**: Average
- **Operator**: LessThan (fires when availability drops below threshold)
- **Evaluation Frequency**: 1 minute (PT1M)
- **Time Window**: 1 minute (PT1M)
- **Severity**: 1
- **Auto Mitigate**: false

## 2. Usage
```hcl main.tf
module "storage_availability_alert" {
  source = "./modules/storage-account/alerts/Availability" # update to your source

  # name defaults to alrt-avail-<storage-account-name>
  resource_group_name = "rg-observability"
  scopes              = [module.storage_account.storage_account_id]

  # Default threshold is 100%
  # threshold = 100

  # Optional: custom description
  description = "Storage Account availability below 100% over 1 minute"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = []
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `name` | `string` | `null` | no | Name of the metric alert (defaults to `alrt-avail-<resource-name>`). |
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the alert. |
| `scopes` | `list(string)` | n/a | yes | List of Storage Account resource IDs to monitor. |
| `threshold` | `number` | `100` | no | Availability threshold percentage. Fires when below this value. |
| `description` | `string` | `null` | no | Custom description for the alert. Auto-generated if not provided. |
| `enabled` | `bool` | `true` | no | Whether the alert is enabled. |
| `action_group_ids` | `list(string)` | `[]` | no | Action Group IDs to notify when the alert fires. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `id` | Resource ID of the metric alert. |
| `name` | Name of the metric alert. |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group
- An existing Storage Account
  
Note: This module does not require the `azurerm.dns` provider alias.
