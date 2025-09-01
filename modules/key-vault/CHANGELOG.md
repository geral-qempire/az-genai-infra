# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-08-19
### Added
- Initial release of the Azure Key Vault resource module.
- Naming: `kv-<region-abbrev>-<service_prefix>-<environment>`.
- Configurable security defaults (RBAC authorization, soft delete retention, purge protection, PNA disable by default).
- Optional Private Endpoint support for `privatelink.vaultcore.azure.net` with DNS zone lookup via aliased provider.
- Outputs include `id`, `name`, `vault_uri`, and `private_endpoint_id`.


