# Storage Account Success Server Latency Alert

Creates a metric alert on Storage Account `SuccessServerLatency`.

## Inputs

- `name` (string, optional): Defaults to `alrt-sslat-<storageAccountName>`
- `resource_group_name` (string)
- `scopes` (list(string)): Storage Account resource IDs
- `threshold` (number, default 1000)
- `description` (string, optional)
- `enabled` (bool, default true)
- `action_group_ids` (list(string), default [])


