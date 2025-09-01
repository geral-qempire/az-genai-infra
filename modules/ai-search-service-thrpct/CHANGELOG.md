# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-08-08
### Added
- Initial release of the Azure AI Search Service metric alert for `ThrottledSearchQueriesPercentage`.
- Static threshold criterion with:
  - `severity` = 3
  - `frequency` = PT1M
  - `window_size` = PT5M
  - `aggregation` = Average
  - `operator` = GreaterThan
  - `metric_namespace` = Microsoft.Search/searchServices
  - `metric_name` = ThrottledSearchQueriesPercentage
- Configurable inputs: `name`, `resource_group_name`, `scopes`, `threshold`, `description`, `enabled`, `action_group_ids`.
- Outputs: `id`, `name`.


