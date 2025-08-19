/**
 * # Azure Search Service
 *
 * O Azure AI Search é uma infraestrutura de pesquisa escalonável que indexa conteúdo heterogêneo e permite a recuperação por meio de APIs, aplicativos e agentes de IA.
 */

resource "azurerm_search_service" "this" {
  name                          = lower("srch-${lookup(var.region_abbreviations, var.location, false)}-${var.service_prefix}-${var.environment}")
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  hosting_mode                  = var.hosting_mode
  local_authentication_enabled  = (
    var.api_access == "API" || var.api_access == "Both"
  )
  authentication_failure_mode   = (
    var.api_access == "Both" ? "http403" : null
  )
  public_network_access_enabled = var.public_network_access_enabled
  partition_count               = var.sku != "free" ? var.partition_count : null
  replica_count                 = var.sku != "free" ? var.replica_count : null
  semantic_search_sku           = var.semantic_search_sku != "" ? var.semantic_search_sku : null
  tags                          = var.tags

  identity {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }
}