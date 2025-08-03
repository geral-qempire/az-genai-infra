resource "azurerm_private_endpoint" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  # Per your requirement: NIC name is "nic-<name>"
  custom_network_interface_name = "nic-${var.name}"

  private_service_connection {
    # Per your requirement: PSC name is "psc-<name>"
    name                           = "psc-${var.name}"
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = var.is_manual_connection
    request_message                = var.request_message
  }

  # Required DNS Zone Group (at least one ID provided via variable)
  private_dns_zone_group {
    name                 = "dg-${var.name}"
    private_dns_zone_ids = var.private_dns_zone_ids
  }

  tags = var.tags
}
