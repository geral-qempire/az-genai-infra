## 1. Module
Terraform module to create a Custom API Key connection under an Azure AI Project (workspace).

## 2. Usage
```hcl
module "ai_project" {
  source = "../ai-project/resource"
  # ...
}

module "custom_api_key_connection" {
  source = "../api-key-hub-connection/resource"

  ai_project_id   = module.ai_project.ai_project_id
  connection_name = "con_custom_api"
  target_url      = "https://api.example.com"
  api_key         = "replace-with-your-api-key"
  metadata        = {
    Purpose = "example"
  }
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `ai_project_id` | `string` | n/a | yes | Resource ID of the target AI Project. |
| `connection_name` | `string` | n/a | yes | Name of the connection to create under the AI Project. |
| `target_url` | `string` | n/a | yes | Target endpoint URL. |
| `api_key` | `string` | n/a | yes | API key to store in the connection. |
| `metadata` | `map(string)` | `{}` | no | Optional metadata key/values. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `connection_id` | The resource ID of the created connection. |
| `connection_name` | The name of the created connection. |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- AzAPI provider `>= 2.2.0`


