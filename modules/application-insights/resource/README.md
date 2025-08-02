---
title: 'Resource'
description: 'An overview of requirements, inputs, outputs, and usage.'
icon: 'server'
---

## 1. Module
Terraform module to create an Azure Application Insights resource with configurable application type, data retention, and sampling settings.

## 2. Usage
```hcl main.tf
module "application_insights" {
  source = "./modules/application-insights/resource" # update to your source

  name                  = "ai-prod-weu"
  resource_group_name   = "rg-observability-prod"
  location              = "westeurope"
  application_type      = "web"
  retention_days        = 90
  sampling_percentage   = 100
  daily_data_cap_in_gb  = 10

  tags = {
    environment = "prod"
    cost-center = "obs"
    owner       = "platform-team"
  }
}
```

## 3. Inputs
| Name                    | Type          | Default | Required | Description                                                     |
| ----------------------- | ------------- | ------- | :------: | --------------------------------------------------------------- |
| `name`                  | `string`      | n/a     |    yes   | Name of the Application Insights resource.                      |
| `resource_group_name`   | `string`      | n/a     |    yes   | Resource group in which to create the resource.                |
| `location`              | `string`      | n/a     |    yes   | Azure region, e.g. `westeurope`.                               |
| `application_type`      | `string`      | n/a     |    yes   | Type of application. Valid values: **web**, **other**.         |
| `retention_days`        | `number`      | `90`    |    no    | Data retention in days. Valid range **30..730**.               |
| `sampling_percentage`   | `number`      | `100`   |    no    | Percentage of telemetry sampled. Valid range **0..100**.       |
| `daily_data_cap_in_gb`  | `number`      | `null`  |    no    | Daily data volume cap in GB. Valid range **0..1000** or null.  |
| `tags`                  | `map(string)` | `{}`    |    no    | Tags to apply to the resource.                                  |

## 4. Outputs
| Name                   | Description                                    |
| ---------------------- | ---------------------------------------------- |
| `id`                   | Resource ID of the Application Insights.      |
| `name`                 | Name of the Application Insights.             |
| `location`             | Location of the Application Insights.         |
| `application_type`     | The application type.                          |
| `app_id`               | App ID associated with this component.        |
| `instrumentation_key`  | Instrumentation Key for this component.       |
| `connection_string`    | Connection string for SDKs.                   |
| `daily_data_cap_in_gb` | The daily data cap (GB) applied.              |
| `retention_in_days`    | The retention (days) configured.              |
| `sampling_percentage`  | The sampling percentage configured.            |


## 5. Requirements
- Terraform `>= 1.12.1`
- AzureRM provider `>= 4.38.1`
- An existing Azure Resource Group 