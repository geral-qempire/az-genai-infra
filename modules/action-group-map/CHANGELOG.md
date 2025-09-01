# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-01-27
### Added
- Initial release of the Action Group Map module.
- Creates a single Azure Monitor Action Group with multiple email receivers.
- Naming: `ag-<region-abbrev>-<service_prefix>-<environment>` with computed short name (max 12 chars).
- Email receivers use common alert schema.
- Inputs: `environment`, `service_prefix`, `location`, `resource_group_name`, `region_abbreviations`, `enabled`, `email_receivers`, `tags`.
- Outputs: `action_group_id`, `action_group_name`.
