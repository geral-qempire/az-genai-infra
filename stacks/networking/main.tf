/**
 * Networking Stack
 *
 * Creates a resource group, a virtual network, and
 * environment-specific subnets (dev, qua, prd).
 */

########################################
# Abbreviations
########################################
module "region_abbreviations" {
  source = "../../modules/region-abbreviations"
}

########################################
# Resource Group
########################################
resource "azurerm_resource_group" "this" {
  name     = "rg-${module.region_abbreviations.regions[var.location]}-${var.service_prefix}"
  location = var.location
  tags     = var.tags
}

########################################
# Virtual Network
########################################
resource "azurerm_virtual_network" "this" {
  name                = "vnet-${module.region_abbreviations.regions[var.location]}-${var.service_prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

########################################
# Subnets (dev, qua, prd)
########################################
resource "azurerm_subnet" "dev" {
  name                 = "snet-dev"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_address_prefixes["dev"]]
}

resource "azurerm_subnet" "qua" {
  name                 = "snet-qua"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_address_prefixes["qua"]]
}

resource "azurerm_subnet" "prd" {
  name                 = "snet-prd"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_address_prefixes["prd"]]
}
