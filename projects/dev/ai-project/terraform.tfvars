# Subscription IDs
infra_subscription_id = "cb084404-ffbb-4bca-8a99-272625f6008a"
dns_subscription_id   = "cb084404-ffbb-4bca-8a99-272625f6008a"

# Core
service_prefix = "ai-proj-01"
location       = "swedencentral"
environment    = "dev"

# Tags
tags = {
  environment     = "DEV"
  useCase         = "AI-PROJECT"
  costCenter      = "41000 - DDA"
  businessUnit    = "41400 - DDA-DATA SCIENCE"
  applicationName = "MAAIF"
  applicationCode = "CA1148"
}

# Existing AI Hub (from framework-core deployment)
hub_resource_group_name = "rg-sdc-frame-core"
hub_name                = "hub-sdc-frame-core-dev"

# AD Groups
ad_read_group_id = "188bbe45-d58e-4f42-a97c-f46cec30ba6d"
ad_full_group_id = "059bb0a1-d2f1-49e9-a5c8-d0cf66ec55ac"

# Service Principals
sp_app_id  = "1307ca49-6a7f-4d2a-8642-e4042ae46a65"
sp_cicd_id = "3ff06dab-8286-4d33-80a4-4ad3495b7d726"

# Network (for private endpoints)
subnet_name              = "snet-dev"
vnet_name                = "vnet-sdc-genai-networking"
vnet_resource_group_name = "rg-sdc-genai-networking"
dns_resource_group_name  = "rg-sdc-dns"

# AI Services
ai_services_sku_name               = "S0"
ai_services_model_deployment_names = []

# Action Group
action_group_emails = ["diogoazevedo15@gmail.com"]

# AI Services Alert toggles
ai_services_alert_availability_rate_enabled = true
ai_services_alert_normalized_ttft_enabled   = true
ai_services_alert_ttlt_enabled              = true
ai_services_alert_processed_tokens_enabled  = true
