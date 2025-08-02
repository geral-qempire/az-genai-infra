---
title: 'Resource'
description: 'An overview of requirements, inputs, outputs, and usage.'
icon: 'server'
---

## 1. Module
Terraform module to create an Azure Log Analytics Workspace with fixed SKU and configurable retention days.

## 2. Usage
```hcl main.tf
module "log_analytics_workspace" {
  source = "./modules/log-analytics-workspace" # update to your source

  name                = "law-prod-weu"
  resource_group_name = "rg-observability-prod"
  location            = "westeurope"
  retention_in_days   = 90

  tags = {
    environment = "prod"
    cost-center = "obs"
    owner       = "platform-team"
  }
}
```

## 3. Inputs
| Name                  | Type          | Default | Required | Description                                                     |
| --------------------- | ------------- | ------- | :------: | --------------------------------------------------------------- |
| `name`                | `string`      | n/a     |    yes   | Name of the Log Analytics workspace.                            |
| `resource_group_name` | `string`      | n/a     |    yes   | Resource group in which to create the workspace.                |
| `location`            | `string`      | n/a     |    yes   | Azure region, e.g. `westeurope`.                                |
| `retention_in_days`   | `number`      | `30`    |    no    | Valid range **30..730** for PerGB2018. |
| `tags`                | `map(string)` | `{}`    |    no    | Tags to apply to the workspace.                                 |

## 4. Outputs
| Name                   | Description                         |
| ---------------------- | ----------------------------------- |
| `id`                   | Resource ID of the workspace.       |
| `name`                 | Workspace name.                     |
| `workspace_id`         | Workspace/Customer GUID.            |
| `primary_shared_key`   | Primary shared key (sensitive).     |
| `secondary_shared_key` | Secondary shared key (sensitive).   |


## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group