infra_subscription_id = "2a4f4e29-3789-4e47-867d-62a6eb17950b" # REQUIRED: target subscription ID
environment           = "dev"                                   # optional (defaults to dev)
service_prefix        = "genai-log"                               # REQUIRED: project prefix
location              = "swedencentral"                            # REQUIRED: Azure region

law_sku               = "PerGB2018"
law_retention_in_days = 30
law_daily_quota_gb    = -1

tags = {
  owner = "platform"
}

# aad_read_access_group = "b1d5976b-b73f-443f-8c6c-ca4a2c0772ef" # TODO: set real group object ID
# aad_full_access_group = "dfe97335-bf84-4e05-b71e-2dfebfab3515" # TODO: set real group object ID


