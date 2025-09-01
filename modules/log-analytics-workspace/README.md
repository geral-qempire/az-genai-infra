## 1. Module
Terraform module to create an Azure Log Analytics Workspace.

## 2. Usage
```hcl
module "region_abbreviations" {
  source = "../region-abbreviations"
}

module "log_analytics" {
  source = "../log-analytics-workspace"

  environment          = "dev"
  service_prefix       = "acme"
  resource_group_name  = "rg-observability-dev"
  location             = "westeurope"
  region_abbreviations = module.region_abbreviations.regions

  sku               = "PerGB2018"
  retention_in_days = 30
  daily_quota_gb    = -1

  tags = {
    environment = "dev"
    project     = "acme"
  }
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `environment` | `string` | n/a | yes | Environment project (dev, qua or prd). |
| `service_prefix` | `string` | n/a | yes | Prefix or name of the project. |
| `location` | `string` | n/a | yes | Azure region. |
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the workspace. |
| `region_abbreviations` | `map(string)` | n/a | yes | Map of Azure locations to abbreviations. |
| `sku` | `string` | `"PerGB2018"` | no | Workspace SKU. |
| `retention_in_days` | `number` | `30` | no | Data retention in days. (7-730) |
| `daily_quota_gb` | `number` | `-1` | no | Daily ingestion cap in GB. -1 means unlimited. |
| `tags` | `map(string)` | `{}` | no | Tags to apply to the workspace. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `log_analytics_workspace_id` | Resource ID of the Log Analytics Workspace. |
| `log_analytics_workspace_name` | Name of the Log Analytics Workspace. |
| `log_analytics_workspace_customer_id` | The immutable Workspace (Customer) ID (GUID). |
| `log_analytics_workspace_primary_shared_key` | Primary shared key for the Workspace (sensitive). |
| `log_analytics_workspace_secondary_shared_key` | Secondary shared key for the Workspace (sensitive). |

## 5. Requirements
- Terraform `>= 1.12.1, < 2.0.0`
- AzureRM provider `~> 4.38`
- Existing Resource Group


