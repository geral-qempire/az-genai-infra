# Changelog
All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2025-08-02
### Changed
- **Breaking:** `private_dns_zone_ids` is now **required** and must contain at least one ID.
- DNS Zone Group is always created and named `dg-<name>`.

## [0.1.0] - 2025-08-02
### Added
- Initial release of the Private Endpoint module.
- Inputs:
  - `name`, `location`, `resource_group_name`, `subnet_id`
  - `private_connection_resource_id`
  - `subresource_names` (list)
  - `private_dns_zone_ids` (list)
  - `is_manual_connection`, `request_message` (optional)
  - `tags` (optional)
- Behavior:
  - NIC name automatically set to `nic-<name>`
  - Private Service Connection name automatically set to `psc-<name>`
  - DNS Zone Group named `dg-<name>`
- Outputs:
  - `id`, `name`, `custom_network_interface_name`
