## 1. Module
Terraform module to create an Azure AI Hub Project under an existing AI Hub.

## 2. Usage
```hcl
module "region_abbreviations" {
  source = "../region-abbreviations"
}

module "ai_project" {
  source = "../ai-project"

  environment          = "dev"
  service_prefix       = "acme"
  resource_group_name  = "rg-ignored-for-project" # Project derives RG from Hub; keep for consistency
  location             = "westeurope"
  region_abbreviations = module.region_abbreviations.regions

  hub_id = module.ai_hub.id

  # Optional friendly name
  # friendly_name = "Acme GenAI Project"

  identity = {
    type = "SystemAssigned"
  }

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
| `region_abbreviations` | `map(string)` | n/a | yes | Map of Azure locations to abbreviations. |
| `hub_id` | `string` | n/a | yes | Resource ID of the parent AI Hub to attach the project to. |
| `friendly_name` | `string` | `""` | no | Optional display name for the project. |
| `identity` | `object` | `{ type = "SystemAssigned" }` | no | Managed identity configuration. |
| `tags` | `map(string)` | `{}` | no | Tags to apply to the project. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `ai_project_id` | Resource ID of the AI Project. |
| `ai_project_name` | Name of the AI Project. |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- Existing AI Hub


