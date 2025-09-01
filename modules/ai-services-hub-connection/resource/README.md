## 1. Module
Terraform module to create an Azure AI Services connection under an Azure AI Project (workspace).

Note: Ensure the target Azure AI Services resource has `local_authentication_enabled = true` to allow API key authentication.

## 2. Usage
```hcl
module "ai_services" {
  source = "../ai-services/resource"
  # ...
}

module "ai_project" {
  source = "../ai-project/resource"
  # ...
}

module "ai_services_connection" {
  source = "../ai-services-hub-connection/resource"

  parent_id          = module.ai_project.ai_project_id
  ai_services_module = module.ai_services
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `parent_id` | `string` | n/a | yes | Parent resource ID (AI Project workspace). |
| `ai_services_module` | `object` | `null` | no | Pass `module.ai_services` directly. |
|  |  |  |  |  |

## 4. Outputs
| Name | Description |
|------|-------------|
| `connection_id` | The resource ID of the created connection. |
| `connection_name` | The name of the created connection. |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- AzAPI provider `>= 2.2.0`


