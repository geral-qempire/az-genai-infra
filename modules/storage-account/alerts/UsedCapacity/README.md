---
title: 'UsedCapacity'
description: 'Total used capacity (bytes) for the storage account'
icon: 'bell'
---

## 1. Alert
Total used capacity for the Storage Account.

- Metric: `UsedCapacity`
- Namespace: `Microsoft.Storage/storageAccounts`
- Aggregation: Average
- Operator: GreaterThan (fires when used capacity exceeds threshold)
- Evaluation Frequency: 1 minute (PT1M)
- Time Window: 5 minutes (PT5M)
- Severity: 2

## 2. Usage
```hcl main.tf
module "storage_used_capacity_alert" {
  source = "./modules/storage-account/alerts/UsedCapacity" # update to your source

  # name defaults to alrt-used-<storage-account-name>
  resource_group_name = "rg-observability"
  scopes              = [module.storage_account.storage_account_id]

  # Default threshold is 5e+14 (bytes)
  # threshold = 5e+14

  # Optional: custom description
  description = "Storage Account used capacity above threshold over 5 minutes"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = []
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `name` | `string` | `null` | no | Name of the metric alert (defaults to `alrt-used-<resource-name>`). |
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the alert. |
| `scopes` | `list(string)` | n/a | yes | List of Storage Account resource IDs to monitor. |
| `threshold` | `number` | `5e+14` | no | Used capacity threshold in bytes. Fires when above this value. |
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


