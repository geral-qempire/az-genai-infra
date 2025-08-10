resource "azurerm_ai_foundry_project" "this" {
  name          = lower("proj-${lookup(var.region_abbreviations, var.location, "")}-${var.service_prefix}-${var.environment}")
  location      = var.location
  ai_services_hub_id = var.hub_id

  friendly_name = var.friendly_name != "" ? var.friendly_name : null
  tags          = var.tags

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }
}


