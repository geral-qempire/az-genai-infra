## 1. Module
Terraform module to create an Azure SQL Server (logical server) with optional Microsoft Entra administrator and Private Endpoint.

## 2. Usage
```hcl
module "region_abbreviations" {
  source = "../region-abbreviations"
}

module "sql_server" {
  source = "../sql-server"

  environment          = "dev"
  service_prefix       = "acme"
  resource_group_name  = "rg-platform-dev"
  location             = "westeurope"
  region_abbreviations = module.region_abbreviations.regions

  serial_number                 = "01"
  administrator_login           = "sqladmin"
  administrator_login_password  = "REDACTED"
  server_version                = "12.0"
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false

  # Entra admin (optional)
  entra_admin_login_name = "DB Admins"
  entra_admin_object_id  = "00000000-0000-0000-0000-000000000000"

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
| `resource_group_name` | `string` | n/a | yes | Resource group in which to create the SQL Server. |
| `region_abbreviations` | `map(string)` | n/a | yes | Map of Azure locations to abbreviations. |
| `serial_number` | `string` | n/a | yes | Serial suffix for the server name. |
| `administrator_login` | `string` | n/a | yes | SQL admin login. |
| `administrator_login_password` | `string` | n/a | yes | SQL admin password. |
| `entra_admin_login_name` | `string` | `""` | no | Entra admin login name. |
| `entra_admin_object_id` | `string` | `""` | no | Entra admin object id. |
| `entra_admin_tenant_id` | `string` | `""` | no | Entra admin tenant id (defaults to current). |
| `server_version` | `string` | `"12.0"` | no | SQL Server version. |
| `minimum_tls_version` | `string` | `"1.2"` | no | Minimum TLS version. |
| `public_network_access_enabled` | `bool` | `false` | no | Allow public network access. |
| `identity` | `object` | `{ type = "SystemAssigned" }` | no | Managed identity configuration. |
| `enable_private_endpoint` | `bool` | `true` | no | Create a Private Endpoint. |
| `dns_resource_group_name` | `string` | `""` | no | RG with Private DNS Zone `privatelink.database.windows.net`. |
| `subnet_id` | `string` | `""` | no | Subnet ID for the Private Endpoint. |
| `private_endpoint_location` | `string` | `""` | no | Location for the Private Endpoint. |
| `tags` | `map(string)` | `{}` | no | Tags to apply to resources. |

## 4. Outputs
| Name | Description |
|------|-------------|
| `id` | Resource ID of the SQL Server. |
| `name` | Name of the SQL Server. |
| `fully_qualified_domain_name` | FQDN of the SQL Server. |
| `principal_id` | MSI Principal ID (if identity is enabled). |
| `private_endpoint_id` | The ID of the Private Endpoint if created, otherwise `null`. |

## 5. Requirements
- Terraform `>= 1.12.1, < 2.0.0`
- AzureRM provider `~> 4.38`
- Existing Resource Group


