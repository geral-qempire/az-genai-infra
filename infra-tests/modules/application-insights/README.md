# Application Insights Module Test

This directory contains a test configuration for the Application Insights module.

## Quick Start

1. **Copy the example variables file:**
   ```bash
   cp terraform.tfvars terraform.tfvars.example
   ```

2. **Edit `terraform.tfvars`** with your Azure subscription details:
   ```hcl
   subscription_id = "your-subscription-id"
   tenant_id       = "your-tenant-id"
   
   # Optional: customize other values
   name_prefix           = "your-test-prefix"
   location              = "westeurope"
   application_type      = "web"
   retention_days        = 90
   sampling_percentage   = 100
   daily_data_cap_in_gb  = 5
   ```

3. **Initialize and apply:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. **Clean up when done:**
   ```bash
   terraform destroy
   ```

## What This Test Does

- Creates a resource group with a random suffix to avoid naming conflicts
- Deploys the Application Insights module with configurable parameters
- Outputs key information including:
  - Application Insights resource ID and name
  - App ID for application registration
  - Instrumentation key and connection string (sensitive)
  - Configuration details (application type, retention, sampling, data cap)

## Configuration Options

| Variable               | Default                    | Description                                    |
| ---------------------- | -------------------------- | ---------------------------------------------- |
| `name_prefix`          | `"test"`                   | Prefix for resource names                      |
| `location`             | `"westeurope"`             | Azure region                                   |
| `application_type`     | `"web"`                    | Application type (web or other)                |
| `retention_days`       | `90`                       | Data retention in days (30-730)               |
| `sampling_percentage`  | `100`                      | Telemetry sampling percentage (0-100)         |
| `daily_data_cap_in_gb` | `null`                     | Daily data cap in GB (null for no limit)      |
| `subscription_id`      | `null`                     | Azure subscription ID                          |
| `tenant_id`            | `null`                     | Azure tenant ID                                |

## Notes

- The test uses random suffixes to prevent naming conflicts across multiple test runs
- Sensitive outputs (instrumentation key, connection string) are marked as sensitive
- The resource group and all resources will be created in the specified location
- Make sure you have appropriate Azure permissions before running the test 