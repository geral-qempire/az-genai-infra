resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id = var.tenant_id
  soft_delete_retention_days = var.soft_delete_retention_days
  sku_name = lower(var.sku)
  purge_protection_enabled   = false
  enable_rbac_authorization  = true
  public_network_access_enabled = false
  network_acls {
    default_action = "Deny"
    bypass         = var.network_rules_bypass
  }

  tags = var.tags
}
