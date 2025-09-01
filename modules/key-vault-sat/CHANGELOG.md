# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-08-08
### Added
- Initial release of the Key Vault SaturationShoebox metric alert.
- Static threshold criterion with:
  - `auto_mitigate` = false
  - `severity` = 1
  - `frequency` = PT1M
  - `window_size` = PT5M
  - `aggregation` = Average
  - `operator` = GreaterThan
  - `metric_namespace` = Microsoft.KeyVault/vaults
  - `metric_name` = SaturationShoebox
- Configurable inputs: `name`, `resource_group_name`, `scopes`, `threshold`, `description`, `enabled`, `action_group_ids`.
- Outputs: `id`, `name`.


