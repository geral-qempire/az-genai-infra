/**
 * # Azure AI Hub (Azure AI Foundry Hub)
 */

locals {
  region_abbreviation = lookup(var.region_abbreviations, var.location, false)
}

resource "azurerm_ai_foundry" "this" {
  name                = lower("hub-${local.region_abbreviation}-${var.service_prefix}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name

  storage_account_id      = var.storage_account_id
  key_vault_id            = var.key_vault_id
  application_insights_id = var.application_insights_id != "" ? var.application_insights_id : null

  friendly_name         = var.friendly_name != "" ? var.friendly_name : null
  public_network_access = var.public_network_access
  tags                  = var.tags

  dynamic "managed_network" {
    for_each = var.managed_network != "" ? [1] : []
    content {
      isolation_mode = var.managed_network
    }
  }

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

########################################
# Optional: FQDN Outbound Rules (chained)
########################################

module "fqdn_outbound_rules" {
  count  = length(var.fqdn_rules)
  source = "../ai-hub-fqdn-outbound-rule"

  name          = "fqdn-${count.index + 1}"
  parent_id     = azurerm_ai_foundry.this.id
  fqdn          = element(var.fqdn_rules, count.index)
  spark_enabled = false

  # Ensure hub is created before creating outbound rules
  depends_on = [azurerm_ai_foundry.this]
}


