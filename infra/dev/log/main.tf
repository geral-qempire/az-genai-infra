module "log_template" {
  source = "../../../templates/log-template"

  infra_subscription_id = var.infra_subscription_id
  environment           = var.environment
  service_prefix        = var.service_prefix
  location              = var.location

  law_sku               = var.law_sku
  law_retention_in_days = var.law_retention_in_days
  law_daily_quota_gb    = var.law_daily_quota_gb

  tags = var.tags
}


