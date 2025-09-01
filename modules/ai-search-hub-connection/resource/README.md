## 1. Module
Terraform module to create an Azure AI Search connection under an Azure AI Project (workspace).

## 2. Usage
```hcl
module "ai_search_service" {
  source = "../ai-search-service/resource"
  # ...
}

module "ai_project" {
  source = "../ai-project/resource"
  # ...
}

module "ai_search_connection" {
  source = "../ai-search-hub-connection/resource"

  parent_id                 = module.ai_project.ai_project_id
  ai_search_service_module  = module.ai_search_service
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `parent_id` | `string` | n/a | yes | Parent resource ID (AI Project workspace). |
| `ai_search_service_module` | `object` | n/a | yes | Pass `module.ai_search_service` directly. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `connection_id` | The resource ID of the created connection. |
| `connection_name` | The name of the created connection. |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- AzAPI provider `>= 2.2.0`


