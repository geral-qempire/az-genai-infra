# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-08-02
### Added
- Initial release of the Azure Log Analytics Workspace resource module.
- Inputs for `name`, `resource_group_name`, `location`, `retention_in_days`, and `tags`.
- Fixed SKU: `PerGB2018` with configurable retention (30-730 days, default 30).
- Input validation for workspace name (non-empty string) and retention period (30-730 days).
- Outputs for `id`, `name`, `workspace_id`, `primary_shared_key`, and `secondary_shared_key`.
- Sensitive handling for shared keys output values. 