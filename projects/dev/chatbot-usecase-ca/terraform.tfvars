# Subscription IDs
infra_subscription_id = "2a4f4e29-3789-4e47-867d-62a6eb17950b"
dns_subscription_id   = "0d2447a1-c993-432b-be88-01ba39e66f84"

# Core
service_prefix = "chatbot-ca"
location       = "swedencentral"
environment    = "dev"

# Tags
tags = {
  environment     = "DEV"
  useCase         = "CA"
  costCenter      = "41000 - DDA"
  businessUnit    = "41400 - DDA-DATA SCIENCE"
  applicationName = "UCO"
  applicationCode = "CA1117"
}

# AD Groups
ad_read_group_id = "bcf79a5f-d4fd-4b6f-ba28-57e050690cc9"
ad_full_group_id = "2a9ee019-37d4-474c-a138-565b2a7c2bb6"

# Service Principals
sp_app_id  = "84f7041e-f33e-4217-84ae-810dac40fa70"
sp_cicd_id = "24e609e8-840e-475c-ac8b-c6e4c074d870"

# Network (for private endpoints)
subnet_name              = "snet-dev"
vnet_name                = "vnet-sdc-genai"
vnet_resource_group_name = "rg-sdc-genai-networking"
dns_resource_group_name  = "rg-swc-dns"

# Framework core (existing)
framework_resource_group_name  = "rg-sdc-chatbot-core"
framework_hub_name             = "hub-sdc-chatbot-core-dev"
framework_storage_account_name = "stsdcchatbotcoredev"
framework_ai_search_name       = "srch-sdc-chatbot-core-dev"

# AI Services
ai_services_sku_name               = "S0"
ai_services_model_deployment_names = []

# Action Group (optional)
action_group_emails = ["diogoazevedo15@gmail.com"]

# Alert toggles (optional, default true)
ai_services_alert_availability_rate_enabled = true
ai_services_alert_normalized_ttft_enabled   = true
ai_services_alert_ttlt_enabled              = true
ai_services_alert_processed_tokens_enabled  = true




