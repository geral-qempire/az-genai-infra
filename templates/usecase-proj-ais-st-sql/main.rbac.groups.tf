########################################
# Conditional RBAC for AD Groups (Simple Use Case)
########################################

locals {
  ad_group_rbac = merge(
    var.ad_read_group_id != null && var.ad_read_group_id != "" ? {
      # Read group assignments (per request)
      read_rg_alert_operator = {
        principal_id         = var.ad_read_group_id
        scope_id             = azurerm_resource_group.this.id
        role_definition_name = "BDSO Alert Operator"
        principal_type       = "Group"
      }
      read_ai_services_reader = {
        principal_id         = var.ad_read_group_id
        scope_id             = module.ai_services.ai_services_id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      read_ai_services_user = {
        principal_id         = var.ad_read_group_id
        scope_id             = module.ai_services.ai_services_id
        role_definition_name = "Cognitive Services User"
        principal_type       = "Group"
      }
      read_ai_services_openai_user = {
        principal_id         = var.ad_read_group_id
        scope_id             = module.ai_services.ai_services_id
        role_definition_name = "Cognitive Services OpenAI User"
        principal_type       = "Group"
      }
      read_ai_project_reader = {
        principal_id         = var.ad_read_group_id
        scope_id             = module.ai_project.ai_project_id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      read_sql_server_reader = {
        principal_id         = var.ad_read_group_id
        scope_id             = module.sql_server.id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      read_sql_database_reader = {
        principal_id         = var.ad_read_group_id
        scope_id             = module.sql_database.id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      read_storage_reader = {
        principal_id         = var.ad_read_group_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      read_storage_blob_reader = {
        principal_id         = var.ad_read_group_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = "Storage Blob Data Reader"
        principal_type       = "Group"
      }
    } : {},

    var.ad_full_group_id != null && var.ad_full_group_id != "" ? {
      # Full group assignments (per request)
      full_rg_alert_operator = {
        principal_id         = var.ad_full_group_id
        scope_id             = azurerm_resource_group.this.id
        role_definition_name = "BDSO Alert Operator"
        principal_type       = "Group"
      }
      full_ai_services_reader = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.ai_services.ai_services_id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      full_ai_services_user = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.ai_services.ai_services_id
        role_definition_name = "Cognitive Services User"
        principal_type       = "Group"
      }
      full_ai_services_openai_contrib = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.ai_services.ai_services_id
        role_definition_name = "Cognitive Services OpenAI Contributor"
        principal_type       = "Group"
      }
      full_ai_project_reader = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.ai_project.ai_project_id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      full_ai_project_bdso_developer = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.ai_project.ai_project_id
        role_definition_name = "BDSO Azure AI Developer"
        principal_type       = "Group"
      }
      full_sql_server_reader = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.sql_server.id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      full_sql_database_reader = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.sql_database.id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      full_storage_reader = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      full_storage_blob_contrib = {
        principal_id         = var.ad_full_group_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = "Storage Blob Data Contributor"
        principal_type       = "Group"
      }
    } : {}
  )
}

module "rbac_ad_groups" {
  source = "../../modules/rbac-map/resource"

  rbac = local.ad_group_rbac
}


