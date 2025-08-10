/**
 * # Azure AI Services
 */

locals {
  region_abbreviation      = lookup(var.region_abbreviations, var.location, false)
  generated_custom_domain  = lower("ais-${local.region_abbreviation}-${var.service_prefix}-${var.environment}")
}

resource "azurerm_ai_services" "this" {
  name                               = lower("ais-${local.region_abbreviation}-${var.service_prefix}-${var.environment}")
  location                           = var.location
  resource_group_name                = var.resource_group_name
  sku_name                           = var.sku_name
  local_authentication_enabled       = var.local_authentication_enabled
  outbound_network_access_restricted = var.local_authentication_enabled
  public_network_access              = var.public_network_access
  custom_subdomain_name              = var.custom_subdomain_name != "" ? var.custom_subdomain_name : local.generated_custom_domain

  tags = var.tags

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  dynamic "storage" {
    for_each = var.storage_account != null ? [var.storage_account] : []
    content {
      storage_account_id = storage.value.storage_account_id
      identity_client_id = try(storage.value.identity_client_id, null)
    }
  }
}


