data "azurerm_private_dns_zone" "blob" {
  provider            = azurerm.dns
  count               = var.enable_private_endpoint_blob ? 1 : 0
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.dns_resource_group_name
}

data "azurerm_private_dns_zone" "file" {
  provider            = azurerm.dns
  count               = var.enable_private_endpoint_file ? 1 : 0
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.dns_resource_group_name
}

data "azurerm_private_dns_zone" "queue" {
  provider            = azurerm.dns
  count               = var.enable_private_endpoint_queue ? 1 : 0
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = var.dns_resource_group_name
}

data "azurerm_private_dns_zone" "table" {
  provider            = azurerm.dns
  count               = var.enable_private_endpoint_table ? 1 : 0
  name                = "privatelink.table.core.windows.net"
  resource_group_name = var.dns_resource_group_name
}

data "azurerm_private_dns_zone" "dfs" {
  provider            = azurerm.dns
  count               = var.enable_private_endpoint_dfs ? 1 : 0
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = var.dns_resource_group_name
}

resource "azurerm_private_endpoint" "blob" {
  count                         = var.enable_private_endpoint_blob ? 1 : 0
  location                      = var.private_endpoint_location != "" ? var.private_endpoint_location : var.location
  name                          = "pep-sta-blob-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-pep-sta-blob-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  tags                          = var.tags

  private_service_connection {
    is_manual_connection           = false
    name                           = "psc-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.blob[0].id]
  }
}

resource "azurerm_private_endpoint" "file" {
  count                         = var.enable_private_endpoint_file ? 1 : 0
  location                      = var.private_endpoint_location != "" ? var.private_endpoint_location : var.location
  name                          = "pep-sta-file-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-pep-sta-file-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  tags                          = var.tags

  private_service_connection {
    is_manual_connection           = false
    name                           = "psc-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["file"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.file[0].id]
  }
}

resource "azurerm_private_endpoint" "queue" {
  count                         = var.enable_private_endpoint_queue ? 1 : 0
  location                      = var.private_endpoint_location != "" ? var.private_endpoint_location : var.location
  name                          = "pep-sta-queue-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-pep-sta-queue-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  tags                          = var.tags

  private_service_connection {
    is_manual_connection           = false
    name                           = "psc-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["queue"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.queue[0].id]
  }
}

resource "azurerm_private_endpoint" "table" {
  count                         = var.enable_private_endpoint_table ? 1 : 0
  location                      = var.private_endpoint_location != "" ? var.private_endpoint_location : var.location
  name                          = "pep-sta-table-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-pep-sta-table-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  tags                          = var.tags

  private_service_connection {
    is_manual_connection           = false
    name                           = "psc-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.table[0].id]
  }
}

resource "azurerm_private_endpoint" "dfs" {
  count                         = var.enable_private_endpoint_dfs ? 1 : 0
  location                      = var.private_endpoint_location != "" ? var.private_endpoint_location : var.location
  name                          = "pep-sta-dfs-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-pep-sta-dfs-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
  tags                          = var.tags

  private_service_connection {
    is_manual_connection           = false
    name                           = "psc-${local.region_abbreviation}-${var.service_prefix}-${var.environment}"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["dfs"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dfs[0].id]
  }
}


