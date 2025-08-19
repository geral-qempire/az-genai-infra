/**
 * # Azure Key Vault
 *
 * Azure Key Vault safeguards cryptographic keys and secrets used by cloud applications and services.
 */

resource "azurerm_key_vault" "this" {
  name                        = lower("kv-${lookup(var.region_abbreviations, var.location, false)}-${var.service_prefix}-${var.environment}")
  resource_group_name         = var.resource_group_name
  location                    = var.location
  tenant_id                   = var.tenant_id
  sku_name                    = var.sku_name
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  public_network_access_enabled = var.public_network_access_enabled
  enable_rbac_authorization   = var.enable_rbac_authorization
  enabled_for_deployment      = var.enabled_for_deployment
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  tags                        = var.tags
}


