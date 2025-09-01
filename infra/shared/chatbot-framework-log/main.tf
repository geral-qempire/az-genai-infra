module "log_template" {
  source = "../../../templates/framework-log"

  infra_subscription_id = var.infra_subscription_id
  environment           = var.environment
  service_prefix        = var.service_prefix
  location              = var.location

  law_sku               = var.law_sku
  law_retention_in_days = var.law_retention_in_days
  law_daily_quota_gb    = var.law_daily_quota_gb

  tags = var.tags

  aad_read_access_group = var.aad_read_access_group
  aad_full_access_group = var.aad_full_access_group
}


