locals {
  region_abbreviation = lookup(var.region_abbreviations, var.location, "")
  project_name        = lower("proj-${local.region_abbreviation}-${var.service_prefix}-${var.environment}")
}

resource "azurerm_ai_foundry_project" "this" {
  name               = local.project_name
  location           = var.location
  ai_services_hub_id = var.hub_id

  friendly_name = var.friendly_name != "" ? var.friendly_name : null
  tags          = var.tags

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


