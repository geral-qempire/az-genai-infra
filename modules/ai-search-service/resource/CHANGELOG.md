# Changelog
All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-08-08
### Added
- Initial release of the Azure AI Search Service resource module.
- Requires shared `region_abbreviations` input (map(string)); recommended to pass from `modules/region-abbreviations`.
- Configurable: `environment`, `service_prefix`, `location`, `sku`, `hosting_mode`, `identity`,
  `local_authentication_enabled`, `public_network_access_enabled`, `partition_count`, `replica_count`,
  `semantic_search_sku`, `enable_private_endpoint`, `dns_resource_group_name`, `subnet_id`, and `tags`.
- Private Endpoint support with DNS zone group association.
- Outputs for `search_service_id` and `search_service_name`.


