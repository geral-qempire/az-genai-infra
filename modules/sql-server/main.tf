/**
 * Azure SQL Server (logical server)
 */

data "azurerm_client_config" "current" {}

locals {
  region_abbreviation = lookup(var.region_abbreviations, var.location, false)
  environment_initial = lower(substr(var.environment, 0, 1))
  server_name         = lower("azpds${local.environment_initial}${var.serial_number}")
 }

resource "azurerm_mssql_server" "this" {
  name                                  = local.server_name
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  version                               = var.server_version
  minimum_tls_version                   = var.minimum_tls_version
  public_network_access_enabled         = var.public_network_access_enabled
  tags                                  = var.tags

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  azuread_administrator {
    login_username = var.entra_admin_login_name
    object_id      = var.entra_admin_object_id
    tenant_id      = var.entra_admin_tenant_id != "" ? var.entra_admin_tenant_id : data.azurerm_client_config.current.tenant_id
  }
}


