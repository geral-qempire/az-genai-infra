data "azurerm_private_dns_zone" "dns_zone" {
  provider            = azurerm.dns
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.dns_resource_group_name
}

locals {
  private_endpoint_name           = "pep-kv-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  private_endpoint_nic_name       = "nic-pep-kv-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  private_service_connection_name = lower("psc-${local.region_abbreviation}-${var.service_prefix}-${var.environment}")
}

resource "azurerm_private_endpoint" "this" {
  count                         = var.enable_private_endpoint ? 1 : 0
  location                      = var.private_endpoint_location != "" ? var.private_endpoint_location : var.location
  name                          = local.private_endpoint_name
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = local.private_endpoint_nic_name
  tags                          = var.tags

  private_service_connection {
    is_manual_connection           = false
    name                           = local.private_service_connection_name
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dns_zone[0].id]
  }
}


