# Private Endpoint Module Test

This directory contains a test configuration for the Private Endpoint module using Azure Key Vault as the target service.

## Multi-Subscription Architecture

This test supports a **multi-subscription setup** commonly used in enterprise environments:

- **Main Subscription**: Contains the VNet, subnet, Key Vault, and Private Endpoint
- **DNS Subscription**: Contains the Private DNS Zones (often managed centrally)

The Terraform configuration uses **provider aliases** to manage resources across both subscriptions seamlessly.

## What This Test Does

- Creates a resource group with a random suffix to avoid naming conflicts
- Deploys a Key Vault with public network access disabled
- Creates a Private Endpoint connecting the Key Vault to your existing VNet/subnet
- Links the Private Endpoint to your existing Private DNS Zone
- Configures proper access policies for testing

## Prerequisites

Before running this test, ensure you have:

1. **Existing Virtual Network** with a dedicated subnet for private endpoints (in main subscription)
2. **Existing Private DNS Zone** for Key Vault (`privatelink.vaultcore.azure.net`) (in DNS subscription)
3. **Proper Azure permissions** in both subscriptions to:
   - Main subscription: Create Key Vault, Private Endpoints, and access VNet/subnet
   - DNS subscription: Read Private DNS Zone
4. **Azure CLI or PowerShell** authenticated with access to both subscriptions
5. **Cross-subscription permissions** or service principal with access to both subscriptions

## Quick Start

1. **Copy the example variables file:**
   ```bash
   cp terraform.tfvars terraform.tfvars.example
   ```

2. **Edit `terraform.tfvars`** with your Azure infrastructure details:
   ```hcl
   subscription_id           = "your-main-subscription-id"
   dns_zone_subscription_id  = "your-dns-zone-subscription-id"
   tenant_id                 = "your-tenant-id"
   
   # Your existing VNet details (in main subscription)
   vnet_name                = "vnet-prod-westeurope"
   vnet_resource_group_name = "rg-networking-prod"
   subnet_name              = "snet-private-endpoints"
   
   # Your existing DNS zone details (in DNS subscription)
   private_dns_zone_name         = "privatelink.vaultcore.azure.net"
   dns_zone_resource_group_name  = "rg-dns-prod"
   
   # Optional: customize other values
   name_prefix = "your-test-prefix"
   location    = "westeurope"
   ```

3. **Initialize and apply:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. **Test the private endpoint** (see Testing section below)

5. **Clean up when done:**
   ```bash
   terraform destroy
   ```

## Testing Private Endpoint Connectivity

After deployment, test that the private endpoint works correctly:

### Method 1: DNS Resolution Test
From a VM in the same VNet:
```bash
# Should resolve to a private IP address (10.x.x.x, 172.x.x.x, or 192.168.x.x)
nslookup <keyvault-name>.vault.azure.net

# Example output (good):
# Address: 10.0.1.4

# Bad example (using public IP):
# Address: 40.64.128.76
```

### Method 2: Azure CLI Test
```bash
# Set a test secret via private endpoint
az keyvault secret set --vault-name <keyvault-name> --name test-secret --value "Hello Private Endpoint"

# Retrieve the secret
az keyvault secret show --vault-name <keyvault-name> --name test-secret --query "value"
```

### Method 3: Network Traffic Verification
```bash
# Use tcpdump or Wireshark to verify traffic stays within your VNet
# Traffic should go to private IP, not public Azure IPs
```

## Configuration Options

| Variable                       | Required | Default                            | Description                                    |
| ------------------------------ | :------: | ---------------------------------- | ---------------------------------------------- |
| `name_prefix`                  |    No    | `"test"`                           | Prefix for resource names                      |
| `location`                     |    No    | `"westeurope"`                     | Azure region                                   |
| `vnet_name`                    |   Yes    | n/a                                | Name of existing VNet (main subscription)      |
| `vnet_resource_group_name`     |   Yes    | n/a                                | Resource group of existing VNet (main subscription) |
| `subnet_name`                  |   Yes    | n/a                                | Name of subnet for private endpoints           |
| `private_dns_zone_name`        |    No    | `"privatelink.vaultcore.azure.net"`| Private DNS zone for Key Vault                |
| `dns_zone_resource_group_name` |   Yes    | n/a                                | Resource group of DNS zone (DNS subscription) |
| `subscription_id`              |    No    | `null`                             | Main Azure subscription ID                     |
| `dns_zone_subscription_id`     |   Yes    | n/a                                | DNS zone Azure subscription ID                 |
| `tenant_id`                    |    No    | `null`                             | Azure tenant ID (same for both subscriptions) |

## Key Features Tested

**Private Endpoint Module:**
- ✅ Private connectivity to Azure Key Vault
- ✅ Automatic naming conventions (nic-, psc-, dg- prefixes)
- ✅ DNS zone group integration
- ✅ Subnet placement and network isolation

**Infrastructure Integration:**
- ✅ Integration with existing VNet and subnet
- ✅ Integration with existing Private DNS zones
- ✅ Proper access policy configuration

**Security:**
- ✅ Public network access disabled on Key Vault
- ✅ Private-only connectivity via VNet
- ✅ DNS resolution through private zone

## Troubleshooting

**DNS Resolution Issues:**
- Verify the Private DNS Zone is linked to your VNet
- Check that the DNS zone name matches exactly: `privatelink.vaultcore.azure.net`
- Ensure your VM uses Azure DNS (168.63.129.16)

**Access Issues:**
- Verify your Azure identity has Key Vault permissions
- Check that the private endpoint connection is approved
- Confirm the subnet allows private endpoint connections

**Network Connectivity:**
- Verify NSG rules allow traffic on port 443
- Check route tables don't override private endpoint routes
- Ensure no firewall blocks private IP ranges

## Notes

- **Multi-subscription setup**: Uses two Azure providers to access resources in different subscriptions
- The test creates a Key Vault with `public_network_access_enabled = false`
- Soft delete is enabled with 7-day retention for easier testing
- Random suffixes prevent naming conflicts across multiple test runs
- The Key Vault includes access policies for the current Azure identity
- Clean up requires purging the Key Vault due to soft delete protection
- Ensure your authentication method (Azure CLI, service principal) has access to both subscriptions 