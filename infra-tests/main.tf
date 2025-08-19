module "base_resources" {
  source = "../templates/base-resources"

  infra_subscription_id = var.infra_subscription_id
  dns_subscription_id   = var.dns_subscription_id

  environment           = var.environment
  service_prefix        = var.service_prefix
  location              = var.location

  dns_resource_group_name = var.dns_resource_group_name
  vnet_resource_group_name = var.vnet_resource_group_name
  vnet_name                = var.vnet_name
  subnet_name              = var.subnet_name

  log_analytics_workspace_name                   = var.log_analytics_workspace_name
  log_analytics_workspace_resource_group_name    = var.log_analytics_workspace_resource_group_name

  tags = var.tags
}


 