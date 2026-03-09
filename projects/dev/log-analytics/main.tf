module "log_analytics" {
  source = "../../../stacks/log-analytics"

  environment    = var.environment
  service_prefix = var.service_prefix
  location       = var.location

  sku               = var.sku
  retention_in_days = var.retention_in_days
  daily_quota_gb    = var.daily_quota_gb

  tags = var.tags
}
