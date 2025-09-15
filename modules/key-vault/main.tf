locals {
  region_abbreviation = lookup(var.region_abbreviations, var.location, false)
  key_vault_name      = lower("kv-${local.region_abbreviation}-${var.service_prefix}-${var.environment}")
}

resource "azurerm_key_vault" "this" {
  name                            = local.key_vault_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  tenant_id                       = var.tenant_id
  sku_name                        = var.sku_name
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  enable_rbac_authorization       = var.enable_rbac_authorization
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  network_acls {
    default_action = "Deny"
    bypass         = var.network_acls_bypass
  }

  tags = var.tags
}


