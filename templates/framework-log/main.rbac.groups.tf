########################################
# Conditional RBAC for AD Groups
########################################

locals {
  ad_group_rbac = merge(
    var.aad_read_access_group != null && var.aad_read_access_group != "" ? {
      # Read group assignments
      read_rg_reader = {
        principal_id         = var.aad_read_access_group
        scope_id             = azurerm_resource_group.this.id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      read_law_reader = {
        principal_id         = var.aad_read_access_group
        scope_id             = module.log_analytics_workspace.log_analytics_workspace_id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
    } : {},

    var.aad_full_access_group != null && var.aad_full_access_group != "" ? {
      # Full group assignments
      full_rg_reader = {
        principal_id         = var.aad_full_access_group
        scope_id             = azurerm_resource_group.this.id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      full_law_reader = {
        principal_id         = var.aad_full_access_group
        scope_id             = module.log_analytics_workspace.log_analytics_workspace_id
        role_definition_name = "Reader"
        principal_type       = "Group"
      }
      full_law_contributor = {
        principal_id         = var.aad_full_access_group
        scope_id             = module.log_analytics_workspace.log_analytics_workspace_id
        role_definition_name = "Contributor"
        principal_type       = "Group"
      }
    } : {}
  )
}

module "rbac_ad_groups" {
  source = "../../modules/rbac-map"

  rbac = local.ad_group_rbac
}


