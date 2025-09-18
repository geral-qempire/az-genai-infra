/**
 * Base Framework Template
 * - Creates a foundational RG
 * - Links Application Insights to an existing Log Analytics Workspace
 * - Provisions SQL Server (PNA disabled, Private Endpoint) and SQL Database
 * - Optionally enables SQL Database metric alerts (per-alert toggles)
 */

data "azurerm_client_config" "current" {}

########################################
# Abbreviations
########################################
module "region_abbreviations" {
  source = "git::https://github.com/geral-qempire/az-genai-infra.git//modules/region-abbreviations?ref=regabbr-v0.1.0"
}

########################################
# Resource Group
########################################
resource "azurerm_resource_group" "this" {
  name     = "rg-${module.region_abbreviations.regions[var.location]}-${var.service_prefix}"
  location = var.location
  tags     = var.tags
}

########################################
# Lookups (Log Analytics Workspace, Subnet)
########################################
data "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_subnet" "private_endpoints" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

########################################
# Application Insights (linked to LAW)
########################################
module "application_insights" {
  source = "git::https://github.com/geral-qempire/az-genai-infra.git//modules/application-insights?ref=appi-v0.1.0"

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  workspace_id = data.azurerm_log_analytics_workspace.this.id

  application_type           = "web"
  internet_ingestion_enabled = true
  internet_query_enabled     = true

  tags = var.tags
}

########################################
# SQL Server (PNA disabled, Private Endpoint)
########################################
module "sql_server" {
  source = "git::https://github.com/geral-qempire/az-genai-infra.git//modules/sql-server?ref=sqlsrv-v0.1.0"

  providers = {
    # Forward DNS alias to ensure Private DNS ops use the DNS subscription
    azurerm.dns = azurerm.dns
  }

  entra_admin_tenant_id = var.tenant_id
  environment           = var.environment
  service_prefix        = var.service_prefix
  resource_group_name   = azurerm_resource_group.this.name
  location              = var.location
  region_abbreviations  = module.region_abbreviations.regions

  serial_number                = var.serial_number
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  # Public network access disabled
  public_network_access_enabled = false

  # Required Entra admin for SQL Server
  entra_admin_login_name = var.entra_admin_login_name
  entra_admin_object_id  = var.entra_admin_object_id

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  tags = var.tags
}

########################################
# SQL Database
########################################
module "sql_database" {
  source = "../../modules/sql-database"

  server_id                   = module.sql_server.id
  resource_group_name         = azurerm_resource_group.this.name
  name                        = var.sql_database_name
  sku_name                    = var.sql_database_sku_name
  min_capacity                = var.sql_database_min_capacity
  auto_pause_delay_in_minutes = var.sql_database_auto_pause_delay_in_minutes

  zone_redundant = var.sql_database_zone_redundant

  # Serverless configuration
  is_serverless = var.sql_database_is_serverless

  # Backups
  pitr_days                = var.sql_database_pitr_days
  backup_interval_in_hours = var.sql_database_backup_interval_in_hours
  weekly_ltr_weeks         = var.sql_database_weekly_ltr_weeks
  monthly_ltr_months       = var.sql_database_monthly_ltr_months
  yearly_ltr_years         = var.sql_database_yearly_ltr_years

  # Integrated Alerts
  enable_availability_alert        = var.sql_db_alert_availability_enabled
  enable_storage_alert             = var.sql_db_alert_storage_percent_enabled
  enable_app_cpu_alert             = var.sql_db_alert_app_cpu_percent_enabled
  enable_app_memory_alert          = var.sql_db_alert_app_memory_percent_enabled
  enable_sql_instance_cpu_alert    = var.sql_db_alert_instance_cpu_percent_enabled
  enable_sql_instance_memory_alert = var.sql_db_alert_instance_memory_percent_enabled

  # Alert Configuration
  availability_alert_action_group_ids        = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  storage_alert_action_group_ids             = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  app_cpu_alert_action_group_ids             = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  app_memory_alert_action_group_ids          = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  sql_instance_cpu_alert_action_group_ids    = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  sql_instance_memory_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []

  tags = var.tags
}



########################################
# Key Vault
########################################
module "key_vault" {
  source = "../../modules/key-vault"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  tenant_id                     = var.tenant_id
  sku_name                      = var.key_vault_sku_name
  soft_delete_retention_days    = var.key_vault_soft_delete_retention_days
  purge_protection_enabled      = var.key_vault_purge_protection_enabled
  public_network_access_enabled = false
  enable_rbac_authorization     = true
  network_acls_bypass           = "AzureServices"

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  # Integrated Alerts
  enable_availability_alert = var.key_vault_alert_availability_enabled
  enable_saturation_alert   = var.key_vault_alert_saturation_shoebox_enabled

  # Alert Configuration
  availability_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  saturation_alert_action_group_ids   = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []

  tags = var.tags
}


########################################
# Storage Account
########################################
module "storage_account" {
  source = "../../modules/storage-account"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  account_tier             = var.storage_account_account_tier
  account_replication_type = var.storage_account_account_replication_type
  account_kind             = var.storage_account_account_kind
  access_tier              = var.storage_account_access_tier

  public_network_access_enabled = false

  # Network rules
  network_rules_bypass = ["AzureServices"]

  # Private Endpoints (blob, file)
  enable_private_endpoint_blob  = true
  enable_private_endpoint_file  = true
  enable_private_endpoint_queue = false
  enable_private_endpoint_table = false
  enable_private_endpoint_dfs   = false

  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  # Integrated Alerts
  enable_availability_alert           = var.storage_alert_availability_enabled
  enable_success_server_latency_alert = var.storage_alert_success_server_latency_enabled
  enable_used_capacity_alert          = var.storage_alert_used_capacity_enabled

  # Alert Configuration
  availability_alert_action_group_ids           = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  success_server_latency_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  used_capacity_alert_action_group_ids          = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []

  tags = var.tags
}


########################################
# AI Search
########################################
module "ai_search_service" {
  source = "../../modules/ai-search"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  api_access   = "Both"
  hosting_mode = "default"

  sku                           = var.ai_search_sku
  partition_count               = var.ai_search_partition_count
  replica_count                 = var.ai_search_replica_count
  semantic_search_sku           = var.ai_search_semantic_search_sku
  public_network_access_enabled = false
  network_rule_bypass_option    = "AzureServices"

  identity = {
    type = "SystemAssigned"
  }

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  # Integrated Alerts
  enable_search_latency_alert                 = var.ai_search_alert_search_latency_enabled
  enable_throttled_search_pct_alert           = var.ai_search_alert_throttled_pct_enabled
  search_latency_alert_action_group_ids       = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []
  throttled_search_pct_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []

  tags = var.tags
}

########################################
# AI Services
########################################
module "ai_services" {
  source = "../../modules/ai-services"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  sku_name                     = var.ai_services_sku_name
  local_authentication_enabled = true
  public_network_access        = "Enabled"
  network_acls_bypass          = "AzureServices"

  identity = {
    type = "SystemAssigned"
  }

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  # Integrated Alerts
  enable_availability_rate_alert = var.ai_services_alert_availability_rate_enabled
  enable_processed_tokens_alert  = var.ai_services_alert_processed_tokens_enabled
  enable_ttft_alert              = var.ai_services_alert_normalized_ttft_enabled
  enable_ttlt_alert              = var.ai_services_alert_ttlt_enabled

  # Alert Configuration
  availability_rate_alert_model_deployment_names = var.ai_services_model_deployment_names
  availability_rate_alert_action_group_ids       = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []

  processed_tokens_alert_model_deployment_names = var.ai_services_model_deployment_names
  processed_tokens_alert_action_group_ids       = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []

  ttft_alert_model_deployment_names = var.ai_services_model_deployment_names
  ttft_alert_action_group_ids       = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []

  ttlt_alert_model_deployment_names = var.ai_services_model_deployment_names
  ttlt_alert_action_group_ids       = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : []

  tags = var.tags
}


########################################
# AI Hub
########################################
module "ai_hub" {
  source = "../../modules/ai-hub"

  providers = {
    azurerm.dns = azurerm.dns
  }

  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  storage_account_id      = module.storage_account.storage_account_id
  key_vault_id            = module.key_vault.id
  application_insights_id = module.application_insights.application_insights_id

  public_network_access = "Enabled"
  managed_network       = "AllowOnlyApprovedOutbound"

  identity = {
    type = "SystemAssigned"
  }

  # Private Endpoint
  enable_private_endpoint   = true
  dns_resource_group_name   = var.dns_resource_group_name
  subnet_id                 = data.azurerm_subnet.private_endpoints.id
  private_endpoint_location = var.location

  tags = var.tags

  # Pass optional FQDN outbound rules into AI Hub module
  fqdn_rules = var.fqdn_rules
}

########################################
# AI Hub Private Endpoint Outbound Rules
########################################
module "ai_hub_pep_outbound_rule_ai_services" {
  source = "../../modules/ai-hub-pep-outbound-rule"

  parent_id           = module.ai_hub.ai_hub_id
  service_resource_id = module.ai_services.ai_services_id
  sub_resource_target = "account"

  spark_enabled = false

  depends_on = [module.ai_hub, module.ai_services]
}

# AI Search outbound rule
module "ai_hub_pep_outbound_rule_ai_search" {
  source = "../../modules/ai-hub-pep-outbound-rule"

  parent_id           = module.ai_hub.ai_hub_id
  service_resource_id = module.ai_search_service.search_service_id
  sub_resource_target = "searchService"

  spark_enabled = false

  depends_on = [module.ai_hub, module.ai_search_service]
}

module "ai_hub_pep_outbound_rule_sql_server" {
  source = "../../modules/ai-hub-pep-outbound-rule"

  parent_id           = module.ai_hub.ai_hub_id
  service_resource_id = module.sql_server.id
  sub_resource_target = "sqlServer"

  spark_enabled = false

  depends_on = [module.ai_hub, module.sql_server]
}


########################################
# AI Hub Connections
########################################
module "ai_services_hub_connection" {
  source = "../../modules/ai-services-hub-connection"

  parent_id          = module.ai_hub.ai_hub_id
  ai_services_module = module.ai_services
  depends_on         = [module.ai_hub, module.ai_services, module.ai_hub_pep_outbound_rule_ai_services]
}

module "ai_search_hub_connection" {
  source = "../../modules/ai-search-hub-connection"

  parent_id                = module.ai_hub.ai_hub_id
  ai_search_service_module = module.ai_search_service
  depends_on               = [module.ai_hub, module.ai_search_service, module.ai_hub_pep_outbound_rule_ai_search]
}

module "api_key_hub_connection" {
  source = "../../modules/api-key-hub-connection"

  parent_id       = module.ai_hub.ai_hub_id
  connection_name = "con_storage_blob"
  target_url      = module.storage_account.storage_account_primary_blob_endpoint
  api_key         = module.storage_account.storage_account_primary_access_key
  metadata        = { Purpose = "StorageBlob" }
  depends_on      = [module.ai_hub, module.storage_account]
}


########################################
# AI Project
########################################
module "ai_project" {
  source = "git::https://github.com/geral-qempire/az-genai-infra.git//modules/ai-project?ref=proj-v0.1.0"

  environment          = var.environment
  service_prefix       = "${var.service_prefix}-lab"
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  hub_id = module.ai_hub.ai_hub_id

  identity = {
    type = "SystemAssigned"
  }

  tags = var.tags
}

########################################
# Action Group (Optional)
########################################
locals {
  action_group_receivers = {
    for idx, addr in var.action_group_emails : format("email%02d", idx + 1) => { email_address = addr }
  }
}

module "action_group" {
  count  = length(local.action_group_receivers) > 0 ? 1 : 0
  source = "git::https://github.com/geral-qempire/az-genai-infra.git//modules/action-group-map?ref=agm-v0.1.0"

  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions
  enabled              = true
  email_receivers      = local.action_group_receivers
  tags                 = var.tags
}
