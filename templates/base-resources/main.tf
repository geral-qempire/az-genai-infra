# ######################################################################
# Context and shared modules
# ######################################################################
locals {
  common_tags = merge({
    environment = var.environment
    project     = var.service_prefix
  }, var.tags)
}

module "region_abbreviations" {
  source = "../../modules/region-abbreviations"
}

// Current client/tenant info
data "azurerm_client_config" "current" {}

// ######################################################################
// Data sources
// ######################################################################
data "azurerm_subnet" "privates" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

// Observability: existing Log Analytics Workspace
data "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

// ######################################################################
// Resource Group
// ######################################################################
resource "azurerm_resource_group" "this" {
  name     = "rg-${module.region_abbreviations.regions[var.location]}-${var.service_prefix}"
  location = var.location
  tags     = local.common_tags
}

// ######################################################################
// Application Insights (workspace-based)
// ######################################################################
module "application_insights" {
  source = "../../modules/application-insights/resource"

  # Context
  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions

  # Link to existing Log Analytics Workspace
  workspace_id = data.azurerm_log_analytics_workspace.this.id

  # Defaults: application_type = "web", internet_* = true
  tags = local.common_tags
}

// ######################################################################
// Storage Account
// ######################################################################
module "storage_account" {
  source = "../../modules/storage-account/resource"

  providers = {
    azurerm       = azurerm
    azurerm.dns   = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  public_network_access_enabled = false
  shared_access_key_enabled     = true

  # Allow Azure resources to bypass network restrictions
  network_rules_bypass          = ["AzureServices"]
  network_rules_default_action  = "Deny"

  # Private Endpoints
  enable_private_endpoint_blob  = true
  enable_private_endpoint_file  = true
  enable_private_endpoint_queue = false
  enable_private_endpoint_table = false
  enable_private_endpoint_dfs   = false

  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.location

  tags = local.common_tags
}

// Storage Account Alerts
module "storage_account_availability_alert" {
  source = "../../modules/storage-account/alerts/Availability"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  resource_group_name = azurerm_resource_group.this.name
  scopes              = [module.storage_account.storage_account_id]
}

module "storage_account_success_server_latency_alert" {
  source = "../../modules/storage-account/alerts/SuccessServerLatency"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  resource_group_name = azurerm_resource_group.this.name
  scopes              = [module.storage_account.storage_account_id]
}

module "storage_account_used_capacity_alert" {
  source = "../../modules/storage-account/alerts/UsedCapacity"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  resource_group_name = azurerm_resource_group.this.name
  scopes              = [module.storage_account.storage_account_id]
}


// ######################################################################
// Key Vault
// ######################################################################
module "key_vault" {
  source = "../../modules/key-vault/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  # Context
  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions
  tenant_id            = data.azurerm_client_config.current.tenant_id

  # KV configuration
  sku_name                      = "standard"
  public_network_access_enabled = false
  enable_rbac_authorization     = true

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.location

  tags = local.common_tags
}

// Key Vault Alerts
module "key_vault_availability_alert" {
  source = "../../modules/key-vault/alerts/Availability"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  resource_group_name = azurerm_resource_group.this.name
  scopes              = [module.key_vault.id]
}

module "key_vault_saturation_alert" {
  source = "../../modules/key-vault/alerts/SaturationShoebox"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  resource_group_name = azurerm_resource_group.this.name
  scopes              = [module.key_vault.id]
}

// ######################################################################
// Azure AI Search
// ######################################################################
module "ai_search" {
  source = "../../modules/ai-search-service/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  # Context
  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions


  # Service configuration
  sku                           = "basic"
  public_network_access_enabled = false
  api_access                    = "Both"
  replica_count                 = 1

  # Identity
  identity = {
    type = "SystemAssigned"
  }

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.location

  tags = local.common_tags
}

// ######################################################################
// Azure AI Services
// ######################################################################
module "ai_services" {
  source = "../../modules/ai-services/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  # Context
  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions

  # Service configuration
  sku_name                     = "S0"
  public_network_access        = "Disabled"
  # Required for API key-based connections
  local_authentication_enabled = true

  # Identity
  identity = {
    type = "SystemAssigned"
  }

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.location

  tags = local.common_tags
}

// AI Search Alerts
module "ai_search_search_latency_alert" {
  source = "../../modules/ai-search-service/alerts/SearchLatency"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  resource_group_name = azurerm_resource_group.this.name
  scopes              = [module.ai_search.search_service_id]
}

module "ai_search_throttled_pct_alert" {
  source = "../../modules/ai-search-service/alerts/ThrottledSearchQueriesPercentage"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  resource_group_name = azurerm_resource_group.this.name
  scopes              = [module.ai_search.search_service_id]
}

// ######################################################################
// Azure AI Hub
// ######################################################################
module "ai_hub" {
  source = "../../modules/ai-hub/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  # Context
  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions

  # Dependencies
  storage_account_id      = module.storage_account.storage_account_id
  key_vault_id            = module.key_vault.id
  application_insights_id = module.application_insights.application_insights_id

  # Network and access
  public_network_access = "Enabled"
  managed_network       = "AllowOnlyApprovedOutbound"

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.location

  identity = {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}


// ######################################################################
// Azure AI Project (under Hub)
// ######################################################################
module "ai_project" {
  source = "../../modules/ai-project/resource"

  # Context
  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  # Parent Hub
  hub_id = module.ai_hub.ai_hub_id

  tags = local.common_tags
}

// ######################################################################
// Connections (created under AI Project)
// ######################################################################
module "ai_search_hub_connection" {
  source = "../../modules/ai-search-hub-connection/resource"

  ai_project_id            = module.ai_project.ai_project_id
  ai_search_service_module = module.ai_search

  # Serialize against parent project changes to avoid RP ETag conflicts
  depends_on = [
    module.ai_project
  ]
}

module "blob_hub_connection" {
  source = "../../modules/api-key-hub-connection/resource"

  ai_project_id   = module.ai_project.ai_project_id
  connection_name = "con_${module.storage_account.storage_account_name}"
  target_url      = module.storage_account.storage_account_primary_blob_endpoint
  api_key         = module.storage_account.storage_account_primary_access_key
  metadata        = {
    Purpose = "Storage account blob connection"
  }

  # Run after the search connection to avoid concurrent mutations of the project workspace
  depends_on = [
    module.ai_search_hub_connection
  ]
}

module "ai_services_hub_connection" {
  source = "../../modules/ai-services-hub-connection/resource"

  ai_project_id       = module.ai_project.ai_project_id
  ai_services_module  = module.ai_services

  # Run last to keep connection operations sequential
  depends_on = [
    module.blob_hub_connection
  ]
}

resource "azurerm_cognitive_deployment" "example" {
  name                 = "example-cd"
  cognitive_account_id = module.ai_services.ai_services_id
  version_upgrade_option = "NoAutoUpgrade"

  model {
    format  = "OpenAI"
    name    = "gpt-4.1-nano"
    version = "2025-04-14"
  }

  sku {
    name = "DataZoneStandard"
    capacity = 100
  }
}



