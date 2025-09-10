
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
# Lookups (Framework, Network, Observability)
########################################
data "azurerm_resource_group" "framework" {
  name = var.framework_resource_group_name
}

data "azurerm_machine_learning_workspace" "framework_hub" {
  name                = var.framework_hub_name
  resource_group_name = data.azurerm_resource_group.framework.name
}

data "azurerm_subnet" "private_endpoints" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

 

########################################
# AI Services (PE + Identity + Integrated Alerts)
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

  # Alerts
  enable_availability_rate_alert = var.ai_services_alert_availability_rate_enabled
  enable_processed_tokens_alert  = var.ai_services_alert_processed_tokens_enabled
  enable_ttft_alert             = var.ai_services_alert_normalized_ttft_enabled
  enable_ttlt_alert             = var.ai_services_alert_ttlt_enabled

  # Action groups for alerts
  availability_rate_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  processed_tokens_alert_action_group_ids  = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  ttft_alert_action_group_ids              = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  ttlt_alert_action_group_ids              = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])

  tags = var.tags
}


########################################
# Storage Account (with integrated alerts)
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

  # Alerts
  enable_availability_alert = var.storage_alert_availability_enabled
  enable_success_server_latency_alert = var.storage_alert_success_server_latency_enabled
  enable_used_capacity_alert = var.storage_alert_used_capacity_enabled

  # Action groups for alerts
  availability_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  success_server_latency_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  used_capacity_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])

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
  environment          = var.environment
  service_prefix       = var.service_prefix
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

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
# SQL Database (with integrated alerts)
########################################
module "sql_database" {
  source = "../../modules/sql-database"
  
  server_id    = module.sql_server.id
  resource_group_name = azurerm_resource_group.this.name
  name         = var.sql_database_name
  sku_name     = var.sql_database_sku_name
  min_capacity = var.sql_database_min_capacity
  auto_pause_delay_in_minutes = var.sql_database_auto_pause_delay_in_minutes

  zone_redundant = var.sql_database_zone_redundant

  # Backups
  pitr_days                = var.sql_database_pitr_days
  backup_interval_in_hours = var.sql_database_backup_interval_in_hours
  weekly_ltr_weeks         = var.sql_database_weekly_ltr_weeks
  monthly_ltr_months       = var.sql_database_monthly_ltr_months
  yearly_ltr_years         = var.sql_database_yearly_ltr_years

  # Alerts
  enable_availability_alert     = var.sql_db_alert_availability_enabled
  enable_storage_alert          = var.sql_db_alert_storage_percent_enabled
  enable_app_cpu_alert          = var.sql_db_alert_app_cpu_percent_enabled
  enable_app_memory_alert       = var.sql_db_alert_app_memory_percent_enabled
  enable_sql_instance_cpu_alert = var.sql_db_alert_instance_cpu_percent_enabled
  enable_sql_instance_memory_alert = var.sql_db_alert_instance_memory_percent_enabled

  # Action groups for alerts
  availability_alert_action_group_ids     = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  storage_alert_action_group_ids          = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  app_cpu_alert_action_group_ids          = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  app_memory_alert_action_group_ids       = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  sql_instance_cpu_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])
  sql_instance_memory_alert_action_group_ids = length(local.action_group_receivers) > 0 ? [module.action_group[0].action_group_id] : (var.action_group_id != null && var.action_group_id != "" ? [var.action_group_id] : [])

  tags = var.tags
}


########################################
# AI Project (Identity)
########################################
module "ai_project" {
  source = "git::https://github.com/geral-qempire/az-genai-infra.git//modules/ai-project?ref=proj-v0.1.0"

  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  region_abbreviations = module.region_abbreviations.regions

  hub_id = data.azurerm_machine_learning_workspace.framework_hub.id

  identity = {
    type = "SystemAssigned"
  }

  tags = var.tags
}

########################################
# Connections (AI Services -> Project)
########################################
module "ai_services_connection" {
  source = "git::https://github.com/geral-qempire/az-genai-infra.git//modules/ai-services-hub-connection?ref=aiscon-v0.1.0"

  parent_id          = module.ai_project.ai_project_id
  ai_services_module = module.ai_services

  depends_on = [module.ai_project, module.ai_services]
}

########################################
# Action Group (Optional)
########################################
locals {
  action_group_receivers = length(var.action_group_email_receivers) > 0 ? var.action_group_email_receivers : {
    for idx, addr in var.action_group_emails : format("email%02d", idx + 1) => { email_address = addr }
  }
}

module "action_group" {
  count = length(local.action_group_receivers) > 0 ? 1 : 0
  source = "git::https://github.com/geral-qempire/az-genai-infra.git//modules/action-group-map?ref=agm-v0.1.0"

  environment          = var.environment
  service_prefix       = var.service_prefix
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  region_abbreviations = module.region_abbreviations.regions

  enabled = var.action_group_enabled

  email_receivers = local.action_group_receivers

  tags = var.tags
}


