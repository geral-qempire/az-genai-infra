# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-08-02
### Added
- Initial release of the Azure Monitor metric alert module for Key Vault `Availability`.
- Inputs for `name`, `resource_group_name`, `scopes`, `threshold`, `enabled`, and `action_group_ids`.
- Fixed policy: `severity = 1`, `frequency = PT1M`, `window_size = PT5M`.
- Outputs for `id` and `name`.
- Monitors Key Vault availability with configurable percentage threshold.
- Alerts when average availability over 5-minute window drops below specified threshold. 