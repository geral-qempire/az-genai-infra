---
title: 'SQL Instance Memory Percent'
description: 'Memory usage by the database engine instance'
icon: 'bell'
---

## 1. Alert
Memory usage by the database engine instance.

- **Metric**: `sql_instance_memory_percent`
- **Namespace**: `Microsoft.Sql/servers/databases`
- **Aggregation**: Average
- **Operator**: GreaterThan (fires when percentage exceeds threshold)
- **Evaluation Frequency**: 5 minutes (PT5M)
- **Time Window**: 5 minutes (PT5M)
- **Severity**: 3

## 2. Usage
```hcl main.tf
module "sql_db_sql_instance_memory_alert" {
  source = "./modules/sql-database/alerts/SqlInstanceMemoryPercent" # update to your source

  # name defaults to alrt-sqlmem-<db-name>
  resource_group_name = "rg-observability"
  scopes              = [module.sql_database.id]

  # Default threshold is 90%
  # threshold = 90

  # Optional: custom description
  description = "SQL instance memory percent above 90% over 5 minutes"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = []
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `name` | `string` | `null` | no | Name of the metric alert (defaults to `alrt-sqlmem-<resource-name>`). |
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the alert. |
| `scopes` | `list(string)` | n/a | yes | List of SQL Database resource IDs to monitor. |
| `threshold` | `number` | `90` | no | Memory percent threshold. Fires when above this value. |
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


