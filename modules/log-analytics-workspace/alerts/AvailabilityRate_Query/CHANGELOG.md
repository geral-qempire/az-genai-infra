# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-08-02
### Added
- Initial release of the Azure Monitor metric alert module for `AvailabilityRate_Query`.
- Inputs for `name`, `resource_group_name`, `scopes`, `threshold`, `enabled`, and `action_group_ids`.
- Fixed policy: `severity = 1`, `frequency = PT5M`, `window_size = PT1H`.
- Outputs for `id` and `name`.
