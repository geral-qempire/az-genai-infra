# Changelog
All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-08-03
### Added
- Initial release of the Azure Key Vault module.
- Inputs:
  - `name`, `location`, `resource_group_name`
  - `soft_delete_retention_days` (default **90**, validated 7–90)
  - `sku` (default **standard**, allowed **standard|premium**)
  - `network_rules_bypass` (default **AzureServices**, allowed **AzureServices|None**)
  - `tags` (optional)
- Fixed enterprise settings:
  - `purge_protection_enabled = false`
  - `enable_rbac_authorization = true`
  - `public_network_access_enabled = false`
  - `network_acls.default_action = "Deny"`, `network_acls.bypass = var.network_rules_bypass`
- Outputs:
  - `id`, `name`, `vault_uri`, `tenant_id`, `sku_name`, `soft_delete_retention_days`, `public_network_access_enabled`
