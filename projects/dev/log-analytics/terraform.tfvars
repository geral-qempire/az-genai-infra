# Subscription
infra_subscription_id = "cb084404-ffbb-4bca-8a99-272625f6008a"

# Core
environment    = "dev"
service_prefix = "genai-log"
location       = "swedencentral"

# Log Analytics
sku               = "PerGB2018"
retention_in_days = 30
daily_quota_gb    = -1

# Tags
tags = {
  environment     = "DEV"
  useCase         = "CHATBOT-COMMON"
  costCenter      = "41000 - DDA"
  businessUnit    = "41400 - DDA-DATA SCIENCE"
  applicationName = "MAAIF"
  applicationCode = "CA1148"
}
