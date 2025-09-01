---
title: 'SQL Instance CPU Percent'
description: 'CPU usage by all user and system workloads on the SQL Database instance'
icon: 'bell'
---

## 1. Alert
CPU usage by all user and system workloads on the SQL Database instance.

- **Metric**: `sql_instance_cpu_percent`
- **Namespace**: `Microsoft.Sql/servers/databases`
- **Aggregation**: Average
- **Operator**: GreaterThan (fires when percentage exceeds threshold)
- **Evaluation Frequency**: 5 minutes (PT5M)
- **Time Window**: 15 minutes (PT15M)
- **Severity**: 3

## 2. Usage
```hcl main.tf
module "sql_db_sql_instance_cpu_alert" {
  source = "./modules/sql-database-sqlcpu" # update to your source

  # name defaults to alrt-sqlcpu-<db-name>
  resource_group_name = "rg-observability"
  scopes              = [module.sql_database.id]

  # Default threshold is 70%
  # threshold = 70

  # Optional: custom description
  description = "SQL instance CPU percent above 70% over 15 minutes"

  # Optional: enable/disable the alert
  enabled = true

  # Optional: notify action groups when alert fires
  action_group_ids = []
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `name` | `string` | `null` | no | Name of the metric alert (defaults to `alrt-sqlcpu-<resource-name>`). |
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the alert. |
| `scopes` | `list(string)` | n/a | yes | List of SQL Database resource IDs to monitor. |
| `threshold` | `number` | `70` | no | CPU percent threshold. Fires when above this value. |
| `description` | `string` | `null` | no | Custom description for the alert. Auto-generated if not provided. |
| `enabled` | `bool` | `true` | no | Whether the alert is enabled. |
| `action_group_ids` | `list(string)` | `[]` | no | Action Group IDs to notify when the alert fires. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `id` | Resource ID of the metric alert. |
| `name` | Name of the metric alert. |

## 5. Requirements
- Terraform `>= 1.12.1, < 2.0.0`
- AzureRM provider `~> 4.38`
- An existing Azure Resource Group
- An existing SQL Database
  
Note: This module does not require the `azurerm.dns` provider alias.


