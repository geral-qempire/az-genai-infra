---
title: 'Storage Percent'
description: 'Percent of database storage used'
icon: 'bell'
---

## 1. Alert
Percent of database storage used.

- **Metric**: `storage_percent`
- **Namespace**: `Microsoft.Sql/servers/databases`
- **Aggregation**: Average
- **Operator**: GreaterThan (fires when percentage exceeds threshold)
- **Evaluation Frequency**: 1 minute (PT1M)
- **Time Window**: 5 minutes (PT5M)
- **Severity**: 3

## 2. Usage
```hcl main.tf
module "sql_db_storage_pct_alert" {
  source = "./modules/sql-database/alerts/StoragePercent" # update to your source

  # name defaults to alrt-stor-<db-name>
  resource_group_name = "rg-observability"
  scopes              = [module.sql_database.id]

  # Default threshold is 80%
  # threshold = 80

  # Optional: custom description
  description = "SQL DB storage percent above 80% over 5 minutes"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = []
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `name` | `string` | `null` | no | Name of the metric alert (defaults to `alrt-stor-<resource-name>`). |
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the alert. |
| `scopes` | `list(string)` | n/a | yes | List of SQL Database resource IDs to monitor. |
| `threshold` | `number` | `80` | no | Storage percent threshold. Fires when above this value. |
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
- An existing SQL Database


