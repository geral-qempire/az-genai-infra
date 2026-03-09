########################################
# Storage Account Tiers Configuration
########################################

locals {
  storage_account_tiers = {
    tier1 = {
      # Storage Account Configuration
      account_tier                      = "Standard"
      account_replication_type         = "LRS"
      account_kind                      = "StorageV2"
      access_tier                      = "Hot"
      public_network_access_enabled    = false
      shared_access_key_enabled       = true
      infrastructure_encryption_enabled = false
      min_tls_version                  = "TLS1_2"
      network_rules_default_action     = "Deny"
      network_rules_bypass             = ["AzureServices"]

      # Soft Delete Retention (shorter for dev tiers)
      blob_soft_delete_retention_days = 7
      file_soft_delete_retention_days = 7

      # SFTP Configuration
      is_sftp_enabled = false

      # Alerts - Base Requirements
      enable_availability_alert           = true
      enable_success_server_latency_alert = true
      enable_used_capacity_alert         = true

      # RBAC Roles for Tech Leads (ad_full_group_id pattern)
      tech_lead_roles = [
        "Storage Blob Data Contributor",
        "Storage File Data Contributor",
        "Storage Table Data Contributor",
        "Storage Queue Data Contributor",
        "Reader"
      ]

      # RBAC Roles for Developers (ad_read_group_id pattern)
      developer_roles = [
        "Storage Blob Data Reader",
        "Storage File Data Reader",
        "Storage Table Data Reader",
        "Storage Queue Data Reader",
        "Reader"
      ]
    }
    tier2 = {
      # Storage Account Configuration
      account_tier                      = "Standard"
      account_replication_type         = "ZRS"
      account_kind                      = "StorageV2"
      access_tier                      = "Hot"
      public_network_access_enabled    = false
      shared_access_key_enabled       = true
      infrastructure_encryption_enabled = false
      min_tls_version                  = "TLS1_2"
      network_rules_default_action     = "Deny"
      network_rules_bypass             = ["AzureServices"]

      # Soft Delete Retention (longer for qa/prd tiers)
      blob_soft_delete_retention_days = 30
      file_soft_delete_retention_days = 30

      # SFTP Configuration
      is_sftp_enabled = false

      # Alerts - Base Requirements
      enable_availability_alert           = true
      enable_success_server_latency_alert = true
      enable_used_capacity_alert         = true

      # RBAC Roles for Tech Leads (ad_full_group_id pattern)
      tech_lead_roles = [
        "Storage Blob Data Contributor",
        "Storage File Data Contributor",
        "Storage Table Data Contributor",
        "Storage Queue Data Contributor",
        "Reader"
      ]

      # RBAC Roles for Developers (ad_read_group_id pattern)
      developer_roles = [
        "Storage Blob Data Reader",
        "Storage File Data Reader",
        "Storage Table Data Reader",
        "Storage Queue Data Reader",
        "Reader"
      ]
    }
  }

  # Selected tier configuration
  selected_tier = local.storage_account_tiers[var.tier]
}

