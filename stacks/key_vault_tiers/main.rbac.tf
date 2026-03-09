########################################
# RBAC for Key Vault - User Profiles
########################################

locals {
  key_vault_rbac = merge(
    # Tech Leads (ad_full_group_id pattern)
    var.ad_full_group_id != null && var.ad_full_group_id != "" ? {
      for idx, role in local.selected_tier.tech_lead_roles : "full_key_vault_${replace(lower(role), " ", "_")}" => {
        principal_id         = var.ad_full_group_id
        scope_id             = module.key_vault.id
        role_definition_name = role
        principal_type       = "Group"
      }
    } : {},
    # Developers (ad_read_group_id pattern)
    var.ad_read_group_id != null && var.ad_read_group_id != "" ? {
      for idx, role in local.selected_tier.developer_roles : "read_key_vault_${replace(lower(role), " ", "_")}" => {
        principal_id         = var.ad_read_group_id
        scope_id             = module.key_vault.id
        role_definition_name = role
        principal_type       = "Group"
      }
    } : {}
  )
}

module "rbac_key_vault" {
  source = "../../modules/rbac-map"

  rbac = local.key_vault_rbac
}

