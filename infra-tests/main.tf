locals {
  common_tags = {
    environment = var.environment
    project     = var.service_prefix
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.service_prefix}-${var.environment}"
  location = var.location
  tags     = local.common_tags
}

module "region_abbreviations" {
  source = "../modules/region-abbreviations"
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "privates" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = var.vnet_name
}

# Log Analytics Workspace (for App Insights)
module "log_analytics_workspace" {
  source = "../modules/log-analytics-workspace/resource"

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  sku               = var.law_sku
  retention_in_days = var.law_retention_in_days
  daily_quota_gb    = var.law_daily_quota_gb

  tags = local.common_tags
}

# Application Insights (workspace-based)
module "application_insights" {
  source = "../modules/application-insights/resource"

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  workspace_id = module.log_analytics_workspace.log_analytics_workspace_id

  tags = local.common_tags
}

# Storage Account
module "storage_account" {
  source = "../modules/storage-account/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  account_tier             = var.sa_account_tier
  account_replication_type = var.sa_account_replication_type
  account_kind             = var.sa_account_kind
  access_tier              = var.sa_access_tier
  identity                 = var.sa_identity

  public_network_access_enabled     = var.sa_public_network_access_enabled
  shared_access_key_enabled         = var.sa_shared_access_key_enabled
  infrastructure_encryption_enabled = var.sa_infrastructure_encryption_enabled

  enable_private_endpoint_blob  = var.sa_enable_private_endpoint_blob
  enable_private_endpoint_file  = var.sa_enable_private_endpoint_file
  enable_private_endpoint_queue = var.sa_enable_private_endpoint_queue
  enable_private_endpoint_table = var.sa_enable_private_endpoint_table
  enable_private_endpoint_dfs   = var.sa_enable_private_endpoint_dfs

  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.private_endpoint_location

  tags = local.common_tags
}

# Storage alerts (all)
module "storage_availability_alert" {
  source = "../modules/storage-account/alerts/Availability"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-avail-${module.storage_account.storage_account_name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.storage_account.storage_account_id]
  enabled             = true
  action_group_ids    = []
}

module "storage_success_server_latency_alert" {
  source = "../modules/storage-account/alerts/SuccessServerLatency"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-sslat-${module.storage_account.storage_account_name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.storage_account.storage_account_id]
  threshold           = 1000
  enabled             = true
  action_group_ids    = []
}

module "storage_used_capacity_alert" {
  source = "../modules/storage-account/alerts/UsedCapacity"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-used-${module.storage_account.storage_account_name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.storage_account.storage_account_id]
  threshold           = 5e+14
  enabled             = true
  action_group_ids    = []
}

# Key Vault (RBAC only; no access policies)
module "key_vault" {
  source = "../modules/key-vault/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  environment                   = var.environment
  service_prefix                = var.service_prefix
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = var.location
  region_abbreviations          = module.region_abbreviations.regions
  sku_name                      = "standard"
  public_network_access_enabled = false
  enable_rbac_authorization     = true
  identity                      = var.kv_identity

  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.private_endpoint_location

  tags = local.common_tags
}

# Key Vault alerts
module "kv_availability_alert" {
  source = "../modules/key-vault/alerts/Availability"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-avail-${module.key_vault.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.key_vault.id]
  enabled             = true
  action_group_ids    = []
}

module "kv_saturation_alert" {
  source = "../modules/key-vault/alerts/SaturationShoebox"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-sat-${module.key_vault.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.key_vault.id]
  enabled             = true
  action_group_ids    = []
}

# SQL Server
module "sql_server" {
  source = "../modules/sql-server/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  serial_number                    = var.sql_serial_number
  administrator_login              = var.sql_admin_login
  administrator_login_password     = var.sql_admin_password
  entra_admin_login_name           = var.sql_entra_admin_login_name
  entra_admin_object_id            = var.sql_entra_admin_object_id
  entra_admin_tenant_id            = var.sql_entra_admin_tenant_id
  server_version                   = var.sql_version
  minimum_tls_version              = var.sql_minimum_tls_version
  public_network_access_enabled    = var.sql_public_network_access_enabled
  identity                         = var.sql_identity

  enable_private_endpoint   = var.sql_enable_private_endpoint
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.private_endpoint_location

  tags = local.common_tags
}

# SQL Database
module "sql_database" {
  source = "../modules/sql-database/resource"

  server_id      = module.sql_server.id
  name           = var.sql_db_name
  sku_name       = var.sql_db_sku_name
  min_capacity   = var.sql_db_min_capacity
  auto_pause_delay_in_minutes = var.sql_db_auto_pause_delay_in_minutes
  collation      = var.sql_db_collation
  zone_redundant = var.sql_db_zone_redundant

  pitr_days                 = var.sql_db_pitr_days
  backup_interval_in_hours  = var.sql_db_backup_interval_in_hours
  weekly_ltr_weeks          = var.sql_db_weekly_ltr_weeks
  monthly_ltr_months        = var.sql_db_monthly_ltr_months
  yearly_ltr_years          = var.sql_db_yearly_ltr_years

  tags = local.common_tags
}

# SQL Database alerts (all)
module "sql_db_availability_alert" {
  source = "../modules/sql-database/alerts/Availability"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-avail-${module.sql_database.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.sql_database.id]
  enabled             = true
  action_group_ids    = []
}

module "sql_db_storage_pct_alert" {
  source = "../modules/sql-database/alerts/StoragePercent"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-stor-${module.sql_database.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.sql_database.id]
  threshold           = 80
  enabled             = true
  action_group_ids    = []
}

module "sql_db_app_cpu_alert" {
  source = "../modules/sql-database/alerts/AppCpuPercent"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-cpu-${module.sql_database.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.sql_database.id]
  threshold           = 80
  enabled             = true
  action_group_ids    = []
}

module "sql_db_app_memory_alert" {
  source = "../modules/sql-database/alerts/AppMemoryPercent"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-mem-${module.sql_database.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.sql_database.id]
  threshold           = 90
  enabled             = true
  action_group_ids    = []
}

module "sql_db_sql_instance_cpu_alert" {
  source = "../modules/sql-database/alerts/SqlInstanceCpuPercent"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-sqlcpu-${module.sql_database.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.sql_database.id]
  threshold           = 70
  enabled             = true
  action_group_ids    = []
}

module "sql_db_sql_instance_memory_alert" {
  source = "../modules/sql-database/alerts/SqlInstanceMemoryPercent"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-sqlmem-${module.sql_database.name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.sql_database.id]
  threshold           = 90
  enabled             = true
  action_group_ids    = []
}

# AI Search
module "ai_search" {
  source = "../modules/ai-search-service/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  environment                   = var.environment
  service_prefix                = var.service_prefix
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = var.location
  region_abbreviations          = module.region_abbreviations.regions
  sku                           = "basic"
  hosting_mode                  = "default"
  local_authentication_enabled  = false
  public_network_access_enabled = false
  partition_count               = 1
  replica_count                 = 1

  identity = {
    type = "SystemAssigned"
  }

  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.private_endpoint_location

  tags = local.common_tags
}

# AI Search alerts
module "search_latency_alert" {
  source = "../modules/ai-search-service/alerts/SearchLatency"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-lat-${module.ai_search.search_service_name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.ai_search.search_service_id]
  enabled             = true
  action_group_ids    = []
}

module "throttled_search_pct_alert" {
  source = "../modules/ai-search-service/alerts/ThrottledSearchQueriesPercentage"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  name                = "alrt-thrpct-${module.ai_search.search_service_name}"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [module.ai_search.search_service_id]
  enabled             = true
  action_group_ids    = []
}

# AI Services (Azure OpenAI)
module "ai_services" {
  source = "../modules/ai-services/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  environment                  = var.environment
  service_prefix               = var.service_prefix
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  region_abbreviations         = module.region_abbreviations.regions
  sku_name                     = "S0"
  local_authentication_enabled = false
  public_network_access        = "Disabled"

  identity = var.ais_identity

  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.private_endpoint_location

  tags = local.common_tags
}

# AI Services alerts (all)
module "ai_services_availability_alert" {
  source = "../modules/ai-services/alerts/AzureOpenAIAvailabilityRate"

  name                   = "alrt-avail-${module.ai_services.ai_services_name}"
  resource_group_name    = azurerm_resource_group.rg.name
  scopes                 = [module.ai_services.ai_services_id]
  model_deployment_names = var.ai_model_deployment_names
  enabled                = true
  action_group_ids       = []
}

module "ai_services_ttft_alert" {
  source = "../modules/ai-services/alerts/AzureOpenAINormalizedTTFTInMS"

  name                   = "alrt-ttft-${module.ai_services.ai_services_name}"
  resource_group_name    = azurerm_resource_group.rg.name
  scopes                 = [module.ai_services.ai_services_id]
  model_deployment_names = var.ai_model_deployment_names
  enabled                = true
  action_group_ids       = []
}

module "ai_services_ttlt_alert" {
  source = "../modules/ai-services/alerts/AzureOpenAITTLTInMS"

  name                   = "alrt-ttlt-${module.ai_services.ai_services_name}"
  resource_group_name    = azurerm_resource_group.rg.name
  scopes                 = [module.ai_services.ai_services_id]
  model_deployment_names = var.ai_model_deployment_names
  enabled                = true
  action_group_ids       = []
}

module "ai_services_tokens_alert" {
  source = "../modules/ai-services/alerts/ProcessedInferenceTokens"

  name                   = "alrt-tok-${module.ai_services.ai_services_name}"
  resource_group_name    = azurerm_resource_group.rg.name
  scopes                 = [module.ai_services.ai_services_id]
  model_deployment_names = var.ai_model_deployment_names
  enabled                = true
  action_group_ids       = []
}

# AI Hub (Azure AI Foundry) with system-assigned identity
module "ai_hub" {
  source = "../modules/ai-hub/resource"

  providers = {
    azurerm     = azurerm
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  storage_account_id      = module.storage_account.storage_account_id
  key_vault_id            = module.key_vault.id
  application_insights_id = module.application_insights.application_insights_id

  identity = {
    type = "SystemAssigned"
  }

  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.privates.id
  private_endpoint_location = var.private_endpoint_location

  tags = local.common_tags
}

# AI Project with system-assigned identity
module "ai_project" {
  source = "../modules/ai-project/resource"

  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions
  hub_id               = module.ai_hub.ai_hub_id

  identity = {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}


