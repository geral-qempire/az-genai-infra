# Subscription
infra_subscription_id = "cb084404-ffbb-4bca-8a99-272625f6008a"

# Core
service_prefix = "genai-networking"
location       = "swedencentral"

# VNet
vnet_address_space = ["10.0.0.0/16"]

# Subnets
subnet_address_prefixes = {
  dev = "10.0.1.0/24"
  qua = "10.0.2.0/24"
  prd = "10.0.3.0/24"
}

# Tags
tags = {
  environment     = "DEV"
  useCase         = "CHATBOT-COMMON"
  costCenter      = "41000 - DDA"
  businessUnit    = "41400 - DDA-DATA SCIENCE"
  applicationName = "MAAIF"
  applicationCode = "CA1148"
}
