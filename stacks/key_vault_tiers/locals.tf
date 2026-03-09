########################################
# Key Vault Tiers Configuration
########################################

locals {
  key_vault_tiers = {
    tier1 = {
      # Key Vault Configuration
      sku_name                      = "standard"
      soft_delete_retention_days    = 90
      purge_protection_enabled      = true
      public_network_access_enabled = false
      enable_rbac_authorization     = true
      network_acls_bypass           = "AzureServices"
      enable_private_endpoint        = true
      enabled_for_deployment        = false
      enabled_for_disk_encryption   = false
      enabled_for_template_deployment = false

      # Alerts - Base Requirements
      enable_availability_alert = true
      enable_saturation_alert   = true

      # RBAC Roles for Tech Leads (ad_full_group_id pattern)
      tech_lead_roles = [
        "Key Vault Certificates Officer",
        "Key Vault Crypto Officer",
        "Key Vault Secrets Officer",
        "Reader"
      ]

      # RBAC Roles for Developers (ad_read_group_id pattern)
      developer_roles = [
        "Key Vault Certificate User",
        "Key Vault Crypto User",
        "Key Vault Secrets User",
        "Reader"
      ]
    }
    tier2 = {
      # Key Vault Configuration
      sku_name                      = "premium"
      soft_delete_retention_days    = 90
      purge_protection_enabled      = true
      public_network_access_enabled = false
      enable_rbac_authorization     = true
      network_acls_bypass           = "AzureServices"
      enable_private_endpoint        = true
      enabled_for_deployment        = false
      enabled_for_disk_encryption   = false
      enabled_for_template_deployment = false

      # Alerts - Base Requirements
      enable_availability_alert = true
      enable_saturation_alert   = true

      # RBAC Roles for Tech Leads (ad_full_group_id pattern)
      tech_lead_roles = [
        "Key Vault Certificates Officer",
        "Key Vault Crypto Officer",
        "Key Vault Secrets Officer",
        "Reader"
      ]

      # RBAC Roles for Developers (ad_read_group_id pattern)
      developer_roles = [
        "Key Vault Certificate User",
        "Key Vault Crypto User",
        "Key Vault Secrets User",
        "Reader"
      ]
    }
  }

  # Selected tier configuration
  selected_tier = local.key_vault_tiers[var.tier]
}

