## 1. Module
Create Azure AI/ML Hub (Machine Learning workspace) outbound network rules from a single `outbound_rules` map. Supports two rule types: `FQDN` and `private-endpoint`. Rule names are taken from the map keys.

## 2. Usage
```hcl
module "hub_outbound_rules" {
  source = "../hub-outbound-rules"

  workspace_id = azurerm_machine_learning_workspace.hub.id

  outbound_rules = {
    rule0001 = {
      type        = "FQDN"
      destination = "pypi.org"
    }

    rule0002 = {
      type                = "private-endpoint"
      service_resource_id = azurerm_storage_account.sa.id
      sub_resource_target = "blob"
    }

    # rule0003 = { ... }
  }
}
```

## 3. Inputs
| Name | Type | Default | Required | Description |
|------|------|---------|:--------:|-------------|
| `workspace_id` | `string` | n/a | yes | The Machine Learning workspace ID the rules apply to. |
| `outbound_rules` | `map(object)` | n/a | yes | Map keyed by rule name (e.g., `rule0001`). Each value defines either an `FQDN` rule or a `private-endpoint` rule. |

### Outbound Rule Object Properties
| Property | Type | Required | Applies to | Description |
|----------|------|:--------:|-----------|-------------|
| `type` | `string` | yes | both | Rule type: `FQDN` or `private-endpoint`. |
| `destination` | `string` | yes (for FQDN) | FQDN | Destination FQDN (e.g., `pypi.org`). |
| `service_resource_id` | `string` | yes (for private-endpoint) | private-endpoint | Target Azure resource ID (e.g., Storage Account ID). |
| `sub_resource_target` | `string` | yes (for private-endpoint) | private-endpoint | Subresource target (e.g., `blob`, `file`, etc.). |

Constraints:
- When `type = "FQDN"`, `destination` must be set.
- When `type = "private-endpoint"`, both `service_resource_id` and `sub_resource_target` must be set.

## 4. Outputs
| Name | Description |
|------|-------------|
| `outbound_rule_ids` | Map of outbound rule resource IDs keyed by rule name. |

## 5. Requirements
- Terraform `>= 1.12.1, < 2.0.0`
- AzureRM provider `~> 4.38`
- AzAPI provider `~> 2.2.0` (used for `private-endpoint` outbound rules to support additional subresource targets like `searchService`)


