# Key Vault Module Test

This directory contains a test configuration for the Key Vault module and its availability alert.

## What This Test Does

- Creates a resource group with a random suffix to avoid naming conflicts
- Deploys a Key Vault with enterprise security defaults (private access, RBAC authorization)
- Creates an availability alert that monitors Key Vault service availability
- Creates a saturation alert that monitors Key Vault capacity utilization
- Creates a latency alert that monitors Key Vault API response times
- Sets up an Action Group for alert notifications via email
- Configures proper tags for resource organization

## Key Features Tested

**Key Vault Module:**
- ✅ Enterprise security defaults (RBAC authorization, private network access)
- ✅ Configurable soft delete retention (7-90 days)
- ✅ SKU selection (Standard/Premium)
- ✅ Network access controls with Azure services bypass
- ✅ Automatic tenant ID configuration

**Availability Alert Module:**
- ✅ Key Vault availability monitoring (Microsoft.KeyVault/vaults/Availability metric)
- ✅ Configurable threshold percentage (0-100%, fires when below)
- ✅ Severity 0 (Critical) alerts
- ✅ 1-minute evaluation frequency with 5-minute time window
- ✅ Action Group integration for notifications

**Saturation Alert Module:**
- ✅ Key Vault capacity monitoring (Microsoft.KeyVault/vaults/SaturationShoebox metric)
- ✅ Configurable threshold percentage (0-100%, fires when above)
- ✅ Severity 2 (Warning) alerts
- ✅ 1-minute evaluation frequency with 5-minute time window
- ✅ Action Group integration for notifications

**Latency Alert Module:**
- ✅ Key Vault API performance monitoring (Microsoft.KeyVault/vaults/ServiceApiLatency metric)
- ✅ Configurable threshold in milliseconds (fires when above)
- ✅ Severity 1 (Error) alerts
- ✅ 1-minute evaluation frequency with 5-minute time window
- ✅ Action Group integration for notifications

## Quick Start

1. **Copy the example variables file:**
   ```bash
   cp terraform.tfvars terraform.tfvars.example
   ```

2. **Edit `terraform.tfvars`** with your Azure details:
   ```hcl
   subscription_id = "your-subscription-id"
   tenant_id       = "your-tenant-id"
   
   # Customize alert settings
   availability_threshold = 95
   saturation_threshold   = 80
   latency_threshold      = 1000
   alert_email_address    = "your-email@company.com"
   
   # Optional: customize other values
   name_prefix = "your-test-prefix"
   location    = "westeurope"
   sku         = "standard"
   ```

3. **Initialize and apply:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. **Test the deployment** (see Testing section below)

5. **Clean up when done:**
   ```bash
   terraform destroy
   ```

## Testing Key Vault and Alerts

After deployment, test that everything works correctly:

### Method 1: Key Vault Access Test
```bash
# Set a test secret (requires Key Vault Data Officer role or equivalent)
az keyvault secret set --vault-name <keyvault-name> --name test-secret --value "Hello Key Vault"

# Retrieve the secret
az keyvault secret show --vault-name <keyvault-name> --name test-secret --query "value"

# List secrets
az keyvault secret list --vault-name <keyvault-name>
```

### Method 2: Alert Configuration Test
```bash
# View the availability alert configuration
az monitor metrics alert show --name <alert-name> --resource-group <resource-group>

# Check alert rules and conditions
az monitor metrics alert list --resource-group <resource-group>

# View action group configuration
az monitor action-group show --name <action-group-name> --resource-group <resource-group>
```

### Method 3: Monitor Key Vault Metrics
```bash
# View Key Vault availability metrics
az monitor metrics list --resource <keyvault-resource-id> --metric Availability --interval PT1M

# Check recent alert activations
az monitor activity-log list --resource-group <resource-group> --max-events 10
```

## Configuration Options

| Variable                     | Default                    | Description                                    |
| ---------------------------- | -------------------------- | ---------------------------------------------- |
| `name_prefix`                | `"test"`                   | Prefix for resource names                      |
| `location`                   | `"westeurope"`             | Azure region                                   |
| `soft_delete_retention_days` | `90`                       | Key Vault soft delete retention (7-90 days)   |
| `sku`                        | `"standard"`               | Key Vault SKU (standard or premium)           |
| `network_rules_bypass`       | `"AzureServices"`          | Network bypass rules (AzureServices or None)  |
| `availability_threshold`     | `95`                       | Availability alert threshold (0-100, fires when below) |
| `saturation_threshold`       | `80`                       | Saturation alert threshold (0-100, fires when above)   |
| `latency_threshold`          | `1000`                     | Latency alert threshold in milliseconds (fires when above) |
| `alert_email_address`        | `"platform-team@example.com"` | Email for alert notifications             |
| `subscription_id`            | `null`                     | Azure subscription ID                          |
| `tenant_id`                  | `null`                     | Azure tenant ID                                |

## Security Considerations

**Key Vault Security:**
- Public network access is **disabled by default**
- RBAC authorization is **enabled** (no access policies)
- Network ACLs **deny all traffic** by default
- Azure services bypass is **configurable**
- Soft delete protection is **enabled**

**Access Requirements:**
- You need **Key Vault Data Officer** role or equivalent for secret operations
- The Key Vault is configured for **private network access only**
- Consider adding **Private Endpoints** for production use

**Alert Security:**
- Availability monitoring helps detect service disruptions (Severity 0 - Critical)
- Latency monitoring helps detect performance degradation (Severity 1 - Error)
- Saturation monitoring helps with proactive capacity management (Severity 2 - Warning)
- Multiple severity levels ensure appropriate response prioritization
- Action Groups provide reliable notification delivery

## Troubleshooting

**Access Issues:**
- Verify you have proper RBAC permissions (Key Vault Data Officer)
- Check that you're authenticated to the correct Azure tenant
- Confirm the Key Vault exists and is accessible

**Alert Issues:**
- Verify the Action Group email address is correct
- Check that all alerts (availability, latency, and saturation) are enabled and properly configured
- Monitor may take a few minutes to start evaluating new alerts
- Saturation alerts may not fire immediately in new Key Vaults with low usage
- Latency alerts depend on actual Key Vault API usage to generate metrics

**Network Connectivity:**
- Key Vault has public access disabled - consider Private Endpoints
- Ensure Azure services bypass is configured if needed
- Check firewall rules don't block Azure service traffic

## Notes

- The test creates a Key Vault with enterprise security defaults
- Soft delete is enabled with configurable retention period
- Random suffixes prevent naming conflicts across multiple test runs
- The availability alert uses Severity 0 (Critical) for immediate attention
- The latency alert uses Severity 1 (Error) for performance monitoring
- The saturation alert uses Severity 2 (Warning) for proactive capacity management
- Clean up requires purging the Key Vault due to soft delete protection
- Email notifications may take a few minutes to arrive during testing 