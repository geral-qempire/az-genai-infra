## 1. Module
Terraform module to create an Azure Key Vault with security defaults including RBAC authorization, private network access, and configurable soft delete retention.

## 2. Usage
```hcl
module "region_abbreviations" {
  source = "../region-abbreviations"
}

module "key_vault" {
  source = "../key-vault/resource"

  environment          = "dev"
  service_prefix       = "acme"
  resource_group_name  = "rg-security-dev"
  location             = "westeurope"
  region_abbreviations = module.region_abbreviations.regions

  sku_name                      = "standard"
  soft_delete_retention_days    = 90
  purge_protection_enabled      = true
  public_network_access_enabled = false
  enable_rbac_authorization     = true

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
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the Key Vault. |
| `region_abbreviations` | `map(string)` | n/a | yes | Map of Azure locations to abbreviations. |
| `sku_name` | `string` | `"standard"` | no | Key Vault SKU (`standard` or `premium`). |
| `soft_delete_retention_days` | `number` | `90` | no | Soft delete retention in days. |
| `purge_protection_enabled` | `bool` | `true` | no | Enable purge protection. |
| `public_network_access_enabled` | `bool` | `false` | no | Allow public network access. |
| `enable_rbac_authorization` | `bool` | `true` | no | Enable Azure RBAC authorization. |
| `enabled_for_deployment` | `bool` | `false` | no | Allow VM to retrieve certificates. |
| `enabled_for_disk_encryption` | `bool` | `false` | no | Allow Disk Encryption to retrieve secrets. |
| `enabled_for_template_deployment` | `bool` | `false` | no | Allow ARM to retrieve secrets. |
| `enable_private_endpoint` | `bool` | `true` | no | Create a Private Endpoint. |
| `dns_resource_group_name` | `string` | `""` | no | RG with Private DNS Zone `privatelink.vaultcore.azure.net`. |
| `subnet_id` | `string` | `""` | no | Subnet ID for the Private Endpoint. |
| `private_endpoint_location` | `string` | `""` | no | Location for the Private Endpoint. |
| `tags` | `map(string)` | `{}` | no | Tags to apply to resources. |
| `identity` | `object` | `{ type = "SystemAssigned" }` | no | Managed identity configuration. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `id` | Resource ID of the Key Vault. |
| `name` | Name of the Key Vault. |

## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- Existing Resource Group


