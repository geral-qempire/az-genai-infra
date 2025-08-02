# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-08-02
### Added
- Initial release of the Azure Application Insights resource module.
- Inputs for `name`, `resource_group_name`, `location`, `application_type`, `retention_days`, `sampling_percentage`, `daily_data_cap_in_gb`, and `tags`.
- Support for web and other application types with validation.
- Configurable data retention (30-730 days, default 90) and sampling percentage (0-100%, default 100%).
- Optional daily data cap configuration (0-1000 GB or null for platform default).
- Input validation for application name (non-empty string), application type (web/other), retention period (30-730 days), sampling percentage (0-100%), and daily data cap (0-1000 GB or null).
- Outputs for `id`, `name`, `location`, `application_type`, `app_id`, `instrumentation_key`, `connection_string`, `daily_data_cap_in_gb`, `retention_in_days`, and `sampling_percentage`.
- Support for Azure tags to enable resource organization and cost management. 