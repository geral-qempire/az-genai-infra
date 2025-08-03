---
title: 'Resource'
description: 'An overview of requirements, inputs, outputs, and usage.'
icon: 'server'
---

## 1. Module
Terraform module to create an Azure Private Endpoint with automatic naming conventions for network interfaces, private service connections, and DNS zone groups.

## 2. Usage
```hcl main.tf
module "private_endpoint" {
  source = "./modules/private-endpoint/resource" # update to your source

  name                           = "pe-storage-prod"
  resource_group_name            = "rg-networking-prod"
  location                       = "westeurope"
  subnet_id                      = azurerm_subnet.private.id
  private_connection_resource_id = azurerm_storage_account.example.id
  subresource_names              = ["blob"]
  private_dns_zone_ids           = [azurerm_private_dns_zone.blob.id]

  # Optional: for manual approval connections
  is_manual_connection = false
  request_message      = null

  tags = {
    environment = "prod"
    cost-center = "networking"
    owner       = "platform-team"
  }
}
```

## 3. Inputs
| Name                             | Type          | Default | Required | Description                                                     |
| -------------------------------- | ------------- | ------- | :------: | --------------------------------------------------------------- |
| `name`                           | `string`      | n/a     |    yes   | Name of the Private Endpoint.                                   |
| `resource_group_name`            | `string`      | n/a     |    yes   | Resource group in which to create the Private Endpoint.        |
| `location`                       | `string`      | n/a     |    yes   | Azure region, e.g. `westeurope`.                               |
| `subnet_id`                      | `string`      | n/a     |    yes   | ID of the subnet where the Private Endpoint NIC will be created. |
| `private_connection_resource_id` | `string`      | n/a     |    yes   | The ID of the target resource to connect to.                   |
| `subresource_names`              | `list(string)`| n/a     |    yes   | The subresource(s) to connect to (e.g., ["blob"], ["vault"]). |
| `private_dns_zone_ids`           | `list(string)`| n/a     |    yes   | List of Private DNS Zone IDs to link via DNS Zone Group.       |
| `is_manual_connection`           | `bool`        | `false` |    no    | Whether the connection requires manual approval.               |
| `request_message`                | `string`      | `null`  |    no    | A message for manual connections, shown to the approver.       |
| `tags`                           | `map(string)` | `{}`    |    no    | Tags to apply to the Private Endpoint.                         |

## 4. Outputs
| Name                            | Description                                    |
| ------------------------------- | ---------------------------------------------- |
| `id`                            | Resource ID of the Private Endpoint.          |
| `name`                          | Name of the Private Endpoint.                 |
| `custom_network_interface_name` | Name of the NIC created (nic-\<name\>).       |

## 5. Naming Conventions
This module automatically applies consistent naming conventions:
- **Network Interface**: `nic-<name>`
- **Private Service Connection**: `psc-<name>`
- **DNS Zone Group**: `dg-<name>`

## 6. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group
- An existing Virtual Network with a dedicated subnet for Private Endpoints
- Target resource (Storage Account, Key Vault, etc.) in the same region
- Private DNS Zone(s) for the target service 