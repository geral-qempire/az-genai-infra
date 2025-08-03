---
title: 'Resource'
description: 'An overview of requirements, inputs, outputs, and usage.'
icon: 'server'
---

## 1. Module
Terraform module to create an Azure Key Vault with security defaults including RBAC authorization, private network access, and configurable soft delete retention.

## 2. Usage
```hcl main.tf
module "key_vault" {
  source = "./modules/key-vault/resources" # update to your source

  name                        = "kv-prod-weu"
  resource_group_name         = "rg-security-prod"
  location                    = "westeurope"
  tenant_id                   = "00000000-0000-0000-0000-000000000000"
  soft_delete_retention_days  = 90
  sku                         = "standard"
  network_rules_bypass        = "AzureServices"

  tags = {
    environment = "prod"
    cost-center = "security"
    owner       = "platform-team"
  }
}
```

## 3. Inputs
| Name                        | Type          | Default          | Required | Description                                                     |
| --------------------------- | ------------- | ---------------- | :------: | --------------------------------------------------------------- |
| `name`                      | `string`      | n/a              |    yes   | Name of the Key Vault (globally unique).                       |
| `resource_group_name`       | `string`      | n/a              |    yes   | Resource group in which to create the Key Vault.              |
| `location`                  | `string`      | n/a              |    yes   | Azure region, e.g. `westeurope`.                               |
| `tenant_id`                 | `string`      | n/a              |    yes   | Azure Tenant ID.                                               |
| `soft_delete_retention_days`| `number`      | `90`             |    no    | Soft delete retention in days. Valid range **7..90**.         |
| `sku`                       | `string`      | `"standard"`     |    no    | Key Vault SKU. Valid values: **standard**, **premium**.       |
| `network_rules_bypass`      | `string`      | `"AzureServices"`|    no    | Traffic bypass rules. Valid values: **AzureServices**, **None**.|
| `tags`                      | `map(string)` | `{}`             |    no    | Tags to apply to the Key Vault.                               |

## 4. Outputs
| Name                           | Description                                    |
| ------------------------------ | ---------------------------------------------- |
| `id`                           | Resource ID of the Key Vault.                 |
| `name`                         | Name of the Key Vault.                        |
| `vault_uri`                    | URI of the Key Vault for data plane operations.|
| `tenant_id`                    | Tenant ID the Key Vault is associated with.   |
| `sku_name`                     | SKU name of the Key Vault.                    |
| `soft_delete_retention_days`   | Soft delete retention period (days).          |
| `public_network_access_enabled`| Whether public network access is enabled.     |

## 5. Security Features
This module implements enterprise security defaults:

### Enterprise Security Settings (Fixed):
- **RBAC Authorization**: `enable_rbac_authorization = true`
- **Private Network Access**: `public_network_access_enabled = false`
- **Purge Protection**: `purge_protection_enabled = false` (for easier testing)
- **Network ACLs**: `default_action = "Deny"` with configurable bypass

### Configurable Security Options:
- **Tenant ID**: Specify the Azure tenant for Key Vault association
- **Soft Delete Retention**: 7-90 days (default: 90 days)
- **SKU Selection**: Standard or Premium (affects HSM availability)
- **Network Bypass**: AzureServices or None (for Azure service access)

## 6. Private Network Integration
This Key Vault is configured for **private network access only**:

- Public network access is **disabled by default**
- Access requires **Private Endpoints** or **VNet integration**
- Network ACLs deny all traffic by default
- Configurable bypass for Azure services

**Example with Private Endpoint:**
```hcl
# Create the Key Vault
module "key_vault" {
  source = "./modules/key-vault/resources"
  
  name                = "kv-private-prod"
  resource_group_name = "rg-security-prod"
  location            = "westeurope"
  tenant_id           = "00000000-0000-0000-0000-000000000000"
}

# Create Private Endpoint
module "key_vault_private_endpoint" {
  source = "./modules/private-endpoint/resource"
  
  name                           = "pe-keyvault-prod"
  resource_group_name            = "rg-security-prod"
  location                       = "westeurope"
  subnet_id                      = azurerm_subnet.private.id
  private_connection_resource_id = module.key_vault.id
  subresource_names              = ["vault"]
  private_dns_zone_ids           = [azurerm_private_dns_zone.keyvault.id]
}
```

## 7. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group
- **Private Endpoint or VNet integration** for access (since public access is disabled)
- **RBAC permissions** for Key Vault access (access policies are not used)
