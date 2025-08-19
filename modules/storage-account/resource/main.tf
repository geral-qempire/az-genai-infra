locals {
  region_abbreviation            = lookup(var.region_abbreviations, var.location, "")
  sanitized_service_prefix       = replace(replace(var.service_prefix, "-", ""), "_", "")
  storage_account_name_candidate = lower("st${local.region_abbreviation}${local.sanitized_service_prefix}${var.environment}")
}

resource "azurerm_storage_account" "this" {
  name                              = local.storage_account_name_candidate
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  account_kind                      = var.account_kind
  access_tier                       = var.access_tier
  min_tls_version                   = var.min_tls_version
  public_network_access_enabled     = var.public_network_access_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  tags                              = var.tags

  network_rules {
    default_action = var.network_rules_default_action
    bypass         = var.network_rules_bypass
  }

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }
}


