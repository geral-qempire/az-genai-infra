---
title: 'SuccessServerLatency'
description: 'Average successful request server latency (ms) for the storage account'
icon: 'bell'
---

## 1. Alert
Average server-side latency for successful requests to the Storage Account.

- Metric: `SuccessServerLatency`
- Namespace: `Microsoft.Storage/storageAccounts`
- Aggregation: Average
- Operator: GreaterThan (fires when latency exceeds threshold)
- Evaluation Frequency: 1 minute (PT1M)
- Time Window: 5 minutes (PT5M)
- Severity: 3

## 2. Usage
```hcl main.tf
module "storage_success_server_latency_alert" {
  source = "./modules/storage-account/alerts/SuccessServerLatency" # update to your source

  # name defaults to alrt-sslat-<storage-account-name>
  resource_group_name = "rg-observability"
  scopes              = [module.storage_account.storage_account_id]

  # Default threshold is 1000 ms
  # threshold = 1000

  # Optional: custom description
  description = "Storage Account success server latency above 1000ms over 5 minutes"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = []
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `name` | `string` | `null` | no | Name of the metric alert (defaults to `alrt-sslat-<resource-name>`). |
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the alert. |
| `scopes` | `list(string)` | n/a | yes | List of Storage Account resource IDs to monitor. |
| `threshold` | `number` | `1000` | no | Latency threshold in milliseconds. Fires when above this value. |
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


