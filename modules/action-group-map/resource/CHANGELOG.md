# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2025-01-27
### Changed
- Refactored to create a single action group with multiple email receivers instead of multiple action groups.
- Updated naming convention: `ag-<region-abbrev>-<service_prefix>-<environment>`.
- Simplified email receiver configuration to only require email_address.
- Added short_name variable with validation (max 12 characters).

## [0.1.0] - 2025-01-27
### Added
- Initial release of the Action Group Map module.
- Creates multiple Azure Monitor Action Groups from a single map input.
- Naming convention: `ag-<region-abbrev>-<service_prefix>-<environment>-<key>`.
- Email receivers with `use_common_alert_schema = true`.
- Configurable inputs: `environment`, `service_prefix`, `location`, `resource_group_name`, `region_abbreviations`, `action_groups`, `tags`.
- Outputs: `action_group_ids`, `action_group_names`.
