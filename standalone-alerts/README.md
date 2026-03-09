# Standalone Azure Alerts Module

This module creates Azure Monitor metric alerts for various Azure resources based on their resource IDs. It's designed to be used as a standalone module that can be copied to other projects.

**Note**: This module expects the resource group and action group to already exist. It will load them using data sources and create alerts for the provided resource IDs.

## Features

- **Loads existing resource group and action group** using data sources
- Creates metric alerts for multiple Azure resource types:
  - SQL Database (availability, storage, CPU, memory)
  - Key Vault (availability, saturation)
  - Storage Account (availability, latency, used capacity)
  - AI Search (latency, throttled queries)
  - AI Services (availability, tokens, TTFT, TTLT)
- Configurable alert thresholds, severities, and action groups
- Support for both serverless and provisioned SQL Database alerts
- Model deployment filtering for AI Services alerts
- **Uses existing action group** - just provide the action group name

## File Structure

```
standalone-alerts/
├── main.tf                    # Main resources and alert definitions
├── variables.tf              # Input variables
├── outputs.tf                # Output values
├── providers.tf              # Provider configuration
├── versions.tf               # Version constraints
├── terraform.tfvars.example  # Example configuration
└── README.md                 # This file
```

## Prerequisites

Before using this module, you must have:
1. An existing Azure resource group for alerts
2. An existing action group in that resource group

## Usage

1. Copy the `standalone-alerts` directory to your project
2. Update `terraform.tfvars` with:
   - Your existing resource group name
   - Your existing action group name
   - Resource IDs for the resources you want to monitor
3. Run Terraform commands:

```bash
terraform init
terraform plan
terraform apply
```

## Configuration

### Basic Configuration

```hcl
# Resource group and action group must already exist
resource_group_name = "rg-alerts-monitoring"

tags = {
  environment = "dev"
  owner       = "platform-team"
  costcenter  = "CC1234"
}

# Action Group Configuration
action_group_name = "ag-alerts"

# Optional: Override with a specific action group ID if needed
# action_group_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Insights/actionGroups/ag-alerts"
```

### Resource IDs

Provide resource IDs as maps where the key is a friendly name and the value is the full Azure resource ID:

```hcl
# SQL Database IDs
sql_database_ids = {
  "sqldb-chatbot" = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Sql/servers/.../databases/..."
}

# Key Vault IDs
key_vault_ids = {
  "kv-chatbot" = "/subscriptions/.../resourceGroups/.../providers/Microsoft.KeyVault/vaults/..."
}

# Storage Account IDs
storage_account_ids = {
  "st-chatbot" = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Storage/storageAccounts/..."
}

# AI Search IDs
ai_search_ids = {
  "srch-chatbot" = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Search/searchServices/..."
}

# AI Services IDs
ai_services_ids = {
  "ais-chatbot" = "/subscriptions/.../resourceGroups/.../providers/Microsoft.CognitiveServices/accounts/..."
}
```

### Alert Configuration

Each alert type can be configured with:

- `enabled`: Enable/disable the alert
- `threshold`: Alert threshold value
- `severity`: Alert severity (0-4)
- `frequency`: Evaluation frequency (e.g., "PT1M")
- `window_size`: Time window for evaluation (e.g., "PT5M")
- `action_group_ids`: List of action group IDs for notifications (optional - uses loaded action group if empty)

Example:

```hcl
# SQL Database availability alert
sql_db_availability_enabled = true
sql_db_availability_threshold = 90
sql_db_availability_severity = 1
sql_db_availability_action_group_ids = [] # Uses loaded action group
```

**Note**: The module loads the action group specified by `action_group_name` from the resource group. All alerts will use this action group by default. You can override individual alerts by providing specific `action_group_ids` if needed, or override all alerts by providing `action_group_id`.

## Alert Types

### SQL Database Alerts

- **Availability**: Monitors database availability (default: < 90%)
- **Storage**: Monitors storage usage (default: > 80%)
- **App CPU** (Serverless only): Monitors app CPU usage (default: > 80%)
- **App Memory** (Serverless only): Monitors app memory usage (default: > 90%)
- **Instance CPU** (Provisioned only): Monitors instance CPU usage (default: > 70%)
- **Instance Memory** (Provisioned only): Monitors instance memory usage (default: > 90%)

### Key Vault Alerts

- **Availability**: Monitors vault availability (default: < 90%)
- **Saturation**: Monitors vault capacity usage (default: > 75%)

### Storage Account Alerts

- **Availability**: Monitors storage availability (default: < 90%)
- **Latency**: Monitors server latency (default: > 500ms)
- **Used Capacity**: Monitors storage usage (default: > 1TB)

### AI Search Alerts

- **Latency**: Monitors search latency (default: > 1000ms)
- **Throttled Queries**: Monitors throttled query percentage (default: > 5%)

### AI Services Alerts

- **Availability**: Monitors service availability (default: < 90%)
- **Tokens**: Monitors processed tokens (default: > 10M)
- **TTFT**: Monitors time to first token (default: > 5ms)
- **TTLT**: Monitors time to last token (default: > 5ms)

## Outputs

The module provides outputs for all created resources:

- **Action Group**: ID, name, and short name of the created action group
- **Resource Group**: ID, name, and location
- **Alerts**: Individual alert IDs and names by type
- **Summary**: All alert IDs and names organized by type

## Requirements

- Terraform >= 1.12.1
- Azure Provider ~> 4.38
- Azure CLI or service principal authentication

## Authentication

The module supports multiple authentication methods:

### Option 1: Azure CLI (Recommended for local development)

1. Install Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
2. Login to Azure: `az login`
3. Set your subscription: `az account set --subscription "your-subscription-id"`

### Option 2: Service Principal

1. Create a service principal: `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/your-subscription-id"`
2. Set environment variables:
   ```bash
   export ARM_CLIENT_ID="your-client-id"
   export ARM_CLIENT_SECRET="your-client-secret"
   export ARM_TENANT_ID="your-tenant-id"
   export ARM_SUBSCRIPTION_ID="your-subscription-id"
   ```

### Option 3: Managed Identity (for Azure-hosted environments)

Uncomment the `use_msi = true` line in `providers.tf`

## Getting Resource IDs

You can get resource IDs using Azure CLI:

```bash
# SQL Database
az sql db show --name "sqldb-chatbot" --server "azpdswechatbot001" --resource-group "rg-we-chatbot" --query "id" -o tsv

# Key Vault
az keyvault show --name "kv-we-chatbot-dev" --resource-group "rg-we-chatbot" --query "id" -o tsv

# Storage Account
az storage account show --name "stwechatbotdev" --resource-group "rg-we-chatbot" --query "id" -o tsv

# AI Search
az search service show --name "srch-we-chatbot-dev" --resource-group "rg-we-chatbot" --query "id" -o tsv

# AI Services
az cognitiveservices account show --name "ais-we-chatbot-dev" --resource-group "rg-we-chatbot" --query "id" -o tsv
```

## Action Groups

The module loads an existing action group by name from the specified resource group. The action group must already exist before running this module.

If you want to use a different action group for all alerts, you can provide the `action_group_id` variable. If you want to use different action groups for specific alerts, you can provide action group IDs in the individual alert configurations.
