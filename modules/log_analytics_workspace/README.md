# Azure Log Analytics Workspace (Terraform Module)

Enterprise-ready Terraform module to create an Azure Log Analytics Workspace with the **PerGB2018** SKU.  
This module lets you choose the **location** and **retention_in_days**, and exposes common outputs (IDs, Portal URL, and shared keys).

## Features
- Opinionated default SKU: `PerGB2018`
- Configurable data retention (`retention_in_days`)
- Pass-through of tags
- Sensitive outputs for shared keys

## Usage

```hcl
module "log_analytics_workspace" {
  source = "./modules/log-analytics-workspace" # update to your source

  name                = "law-prod-weu"
  resource_group_name = "rg-observability-prod"
  location            = "westeurope"

  # 30..730 days for PerGB2018
  retention_in_days   = 90

  tags = {
    environment = "prod"
    cost-center = "obs"
    owner       = "platform-team"
  }
}
```


| Name                  | Type          | Default | Required | Description                                                     |
| --------------------- | ------------- | ------- | :------: | --------------------------------------------------------------- |
| `name`                | `string`      | n/a     |    yes   | Name of the Log Analytics workspace.                            |
| `resource_group_name` | `string`      | n/a     |    yes   | Resource group in which to create the workspace.                |
| `location`            | `string`      | n/a     |    yes   | Azure region, e.g. `westeurope`.                                |
| `retention_in_days`   | `number`      | `30`    |    no    | Data retention in days (valid range **30..730** for PerGB2018). |
| `tags`                | `map(string)` | `{}`    |    no    | Tags to apply to the workspace.                                 |

**Note:** If you later reduce retention, data older than the new retention period may be purged by the platform.

Outputs
| Name                   | Description                         |
| ---------------------- | ----------------------------------- |
| `id`                   | Resource ID of the workspace.       |
| `name`                 | Workspace name.                     |
| `workspace_id`         | Workspace/Customer GUID.            |
| `portal_url`           | Azure Portal URL for the workspace. |
| `primary_shared_key`   | Primary shared key (sensitive).     |
| `secondary_shared_key` | Secondary shared key (sensitive).   |


## Requirements
- Terraform `>= 1.5`
- AzureRM provider `>= 3.70`
- An existing Azure Resource Group


