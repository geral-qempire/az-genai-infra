## 1. Module
Terraform module to create an Azure AI Services account with optional Private Endpoint and identity.

## 2. Usage
```hcl
module "region_abbreviations" {
  source = "../region-abbreviations"
}

module "ai_services" {
  source = "../ai-services"

  environment          = "dev"
  service_prefix       = "acme"
  resource_group_name  = "rg-platform-dev"
  location             = "westeurope"
  region_abbreviations = module.region_abbreviations.regions

  sku_name                     = "S0"
  local_authentication_enabled = false
  public_network_access        = "Disabled"
  custom_subdomain_name        = ""

  # Network ACLs
  network_acls_bypass = "None" # or "AzureServices"

  identity = {
    type = "SystemAssigned"
  }

  # Private Endpoint (optional)
  enable_private_endpoint   = true
  dns_resource_group_name   = "rg-network-dev"
  subnet_id                 = "/subscriptions/xxx/resourceGroups/rg-network-dev/providers/Microsoft.Network/virtualNetworks/vnet-dev/subnets/snet-privates"
  private_endpoint_location = "westeurope"

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
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the AI Services resource. |
| `region_abbreviations` | `map(string)` | n/a | yes | Map of Azure locations to abbreviations. |
| `sku_name` | `string` | `"S0"` | no | AI Services SKU. |
| `local_authentication_enabled` | `bool` | `false` | no | Allow API key authentication. |
| `public_network_access` | `string` | `"Disabled"` | no | Public network access (`Enabled`, `Disabled`). |
| `network_acls_bypass` | `string` | `"None"` | no | Traffic that can bypass AI Services network rules (`None`, `AzureServices`). |
| `custom_subdomain_name` | `string` | `""` | no | Optional custom subdomain name. |
| `identity` | `object` | `{ type = "SystemAssigned" }` | no | Managed identity configuration. |
| `enable_private_endpoint` | `bool` | `true` | no | Create a Private Endpoint. |
| `dns_resource_group_name` | `string` | `""` | no | RG with Private DNS Zone `privatelink.cognitiveservices.azure.com`. |
| `subnet_id` | `string` | `""` | no | Subnet ID for the Private Endpoint. |
| `private_endpoint_location` | `string` | `""` | no | Location for the Private Endpoint. |
| `tags` | `map(string)` | `{}` | no | Tags to apply to resources. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `ai_services_id` | Resource ID of the AI Services. |
| `ai_services_name` | Name of the AI Services. |
| `ai_services_primary_key` | Primary access key for the AI Services account. |
| `ai_services_secondary_key` | Secondary access key for the AI Services account. |
| `private_endpoint_id` | The ID of the Private Endpoint if created, otherwise `null`. |

## 5. Requirements
- Terraform `>= 1.12.1, < 2.0.0`
- AzureRM provider `~> 4.38`


