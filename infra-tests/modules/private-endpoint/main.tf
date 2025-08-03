# Random suffix to avoid name collisions across repeated test runs
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  lower   = true
  special = false
}

# Simple resource group for the test
resource "azurerm_resource_group" "test" {
  name     = "rg-${var.location}-${var.name_prefix}"
  location = var.location

  tags = var.tags
}

# Data sources for existing infrastructure
data "azurerm_virtual_network" "existing" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "existing" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "keyvault" {
  provider            = azurerm.dns
  name                = var.private_dns_zone_name
  resource_group_name = var.dns_zone_resource_group_name
}

# Get current client configuration for Key Vault access policy
data "azurerm_client_config" "current" {}

# Create a Key Vault to test private endpoint connectivity
resource "azurerm_key_vault" "test" {
  name                = "${var.name_prefix}-kv-${random_string.suffix.result}"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # Enable for private endpoint access
  public_network_access_enabled = false
  purge_protection_enabled      = false  # For easier testing cleanup
  soft_delete_retention_days    = 7      # Minimum for testing

  # Access policy for the current user/service principal
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "List",
      "Delete",
      "Purge"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge"
    ]

    certificate_permissions = [
      "Create",
      "Get",
      "List",
      "Delete",
      "Purge"
    ]
  }

  tags = var.tags
}

# Create the private endpoint using our module
module "private_endpoint" {
  source = "../../../modules/private-endpoint/resource"

  name                           = "${var.name_prefix}-pe-kv-${random_string.suffix.result}"
  resource_group_name            = azurerm_resource_group.test.name
  location                       = azurerm_resource_group.test.location
  subnet_id                      = data.azurerm_subnet.existing.id
  private_connection_resource_id = azurerm_key_vault.test.id
  subresource_names              = ["vault"]
  private_dns_zone_ids           = [data.azurerm_private_dns_zone.keyvault.id]

  # Test with automatic approval
  is_manual_connection = false

  tags = var.tags
} 