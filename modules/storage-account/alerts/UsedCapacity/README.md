# Storage Account Used Capacity Alert

Creates a metric alert on Storage Account `UsedCapacity`.

## Inputs

- `name` (string, optional): Defaults to `alrt-used-<storageAccountName>`
- `resource_group_name` (string)
- `scopes` (list(string)): Storage Account resource IDs
- `threshold` (number, default 5e+14)
- `description` (string, optional)
- `enabled` (bool, default true)
- `action_group_ids` (list(string), default [])


