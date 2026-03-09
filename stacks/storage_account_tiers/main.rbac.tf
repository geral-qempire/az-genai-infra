########################################
# RBAC for Storage Account - User Profiles
########################################

locals {
  storage_account_rbac = merge(
    # Tech Leads (ad_full_group_id pattern)
    var.ad_full_group_id != null && var.ad_full_group_id != "" ? {
      for idx, role in local.selected_tier.tech_lead_roles : "full_storage_${replace(lower(role), " ", "_")}" => {
        principal_id         = var.ad_full_group_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = role
        principal_type       = "Group"
      }
    } : {},
    # Developers (ad_read_group_id pattern)
    var.ad_read_group_id != null && var.ad_read_group_id != "" ? {
      for idx, role in local.selected_tier.developer_roles : "read_storage_${replace(lower(role), " ", "_")}" => {
        principal_id         = var.ad_read_group_id
        scope_id             = module.storage_account.storage_account_id
        role_definition_name = role
        principal_type       = "Group"
      }
    } : {}
  )
}

module "rbac_storage_account" {
  source = "../../modules/rbac-map"

  rbac = local.storage_account_rbac
}

