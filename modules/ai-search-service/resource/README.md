## 1. Module
Terraform module to create an Azure AI Search service with optional Private Endpoint and identity.

## 2. Usage
```hcl
module "region_abbreviations" {
  source = "../region-abbreviations"
}

module "ai_search" {
  source = "../ai-search-service/resource"

  environment          = "dev"
  service_prefix       = "acme"
  resource_group_name  = "rg-platform-dev"
  location             = "westeurope"
  region_abbreviations = module.region_abbreviations.regions

  sku                           = "standard"
  partition_count               = 1
  replica_count                 = 1
  semantic_search_sku           = "standard"
  hosting_mode                  = "default"
  local_authentication_enabled  = false
  public_network_access_enabled = false

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
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the Search Service. |
| `region_abbreviations` | `map(string)` | n/a | yes | Map of Azure locations to abbreviations. |
| `sku` | `string` | `"basic"` | no | Search Service SKU. |
| `partition_count` | `number` | `1` | no | Number of partitions (not allowed for `free` SKU). |
| `replica_count` | `number` | `0` | no | Number of replicas. |
| `semantic_search_sku` | `string` | `"free"` | no | Semantic search SKU (`free`, `standard`). |
| `hosting_mode` | `string` | `"default"` | no | Hosting mode (`default`, `highDensity`). |
| `local_authentication_enabled` | `bool` | `false` | no | Allow API key authentication. |
| `public_network_access_enabled` | `bool` | `false` | no | Allow public network access. |
| `identity` | `object` | `{ type = "SystemAssigned" }` | no | Managed identity configuration. |
| `enable_private_endpoint` | `bool` | `true` | no | Create a Private Endpoint. |
| `dns_resource_group_name` | `string` | `""` | no | RG with Private DNS Zone `privatelink.api.azureml.ms`. |
| `subnet_id` | `string` | `""` | no | Subnet ID for the Private Endpoint. |
| `private_endpoint_location` | `string` | `""` | no | Location for the Private Endpoint. |
| `tags` | `map(string)` | `{}` | no | Tags to apply to resources. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `search_service_id` | Resource ID of the Search Service. |
| `search_service_name` | Name of the Search Service. |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- Existing Resource Group

<!-- BEGIN_TF_DOCS -->
# Azure Search Service

O Azure AI Search é uma infraestrutura de pesquisa escalonável que indexa conteúdo heterogêneo e permite a recuperação por meio de APIs, aplicativos e agentes de IA.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.38.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_search_service.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service) | resource |
| [azurerm_private_dns_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |

## Example

This example shows how to deploy the module in its simplest configuration.

```hcl
module "ai_search_services" {
  source                        = "./ai_search_service"
  resource_group_name           = azurerm_resource_group.example.name
  location                      = azurerm_resource_group.example.location
  environment                   = "dev"
  service_prefix                = var.service_prefix
  public_network_access_enabled = false
  enable_private_endpoint       = false
  sku                           = "standard"
  partition_count               = 1
  replica_count                 = 1
  semantic_search_sku           = "standard"
  hosting_mode                  = "default"
}
``` 

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment project (dev, qua or prd) | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the Search Service should exist. Changing this forces a new AI Foundry Hub to be created. | `string` | n/a | yes |
| <a name="input_service_prefix"></a> [service\_prefix](#input\_service\_prefix) | Prefix or name of the project | `string` | n/a | yes |
| <a name="input_dns_resource_group_name"></a> [dns\_resource\_group\_name](#input\_dns\_resource\_group\_name) | DNS zone for the private endpoint. | `string` | `""` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Create a private endpoint to resource | `bool` | `true` | no |
| <a name="input_hosting_mode"></a> [hosting\_mode](#input\_hosting\_mode) | Specifies the Hosting Mode, which allows for High Density partitions (that allow for up to 1000 indexes) should be supported. | `string` | `"default"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | A identity and possibles values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned. | <pre>list(object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  }))</pre> | <pre>{<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | Specifies whether the Search Service allows authenticating using API Keys? | `bool` | `false` | no |
| <a name="input_partition_count"></a> [partition\_count](#input\_partition\_count) | Specifies the number of partitions which should be created. This field cannot be set when using a free sku. | `number` | `1` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | pecifies whether Public Network Access is allowed for this resource. | `bool` | `false` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Specifies the number of Replica's which should be created for this Search Service. | `number` | `0` | no |
| <a name="input_semantic_search_sku"></a> [semantic\_search\_sku](#input\_semantic\_search\_sku) | Specifies the Semantic Search SKU which should be used for this Search Service. | `string` | `""` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU which should be used for this Search Service. | `string` | `"basic"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID for the private endpoint. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to add to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_search_service_id"></a> [search\_service\_id](#output\_search\_service\_id) | The ID of the Search Service. |
| <a name="output_search_service_name"></a> [search\_service\_name](#output\_search\_service\_name) | The Name of the Search Service. |
<!-- END_TF_DOCS -->