# Subscriptions
variable "infra_subscription_id" { type = string }
variable "dns_subscription_id" { type = string }

# Tags
variable "tags" { type = map(string) }

# Setup
variable "service_prefix" { type = string }
variable "location" { type = string }
variable "environment" { type = string }

# Action Group (optional)
variable "action_group_emails" {
  type    = list(string)
  default = []
}

# Network
variable "subnet_name" { type = string }
variable "vnet_name" { type = string }
variable "dns_resource_group_name" { type = string }
variable "vnet_resource_group_name" { type = string }

# AD Groups
variable "ad_read_group_id" {
  type    = string
  default = null
}
variable "ad_full_group_id" {
  type    = string
  default = null
}

# Service Principals
variable "sp_app_id" {
  type    = string
  default = null
}
variable "sp_cicd_id" {
  type    = string
  default = null
}

# Framework core (existing)
variable "framework_resource_group_name" { type = string }
variable "framework_hub_name" { type = string }
variable "framework_storage_account_name" { type = string }
variable "framework_ai_search_name" { type = string }

# AI Services
variable "ai_services_sku_name" {
  type    = string
  default = "S0"
}
variable "ai_services_model_deployment_names" {
  type    = list(string)
  default = []
}

# Alerts (default false)
variable "ai_services_alert_availability_rate_enabled" {
  type    = bool
  default = false
}
variable "ai_services_alert_normalized_ttft_enabled" {
  type    = bool
  default = false
}
variable "ai_services_alert_ttlt_enabled" {
  type    = bool
  default = false
}
variable "ai_services_alert_processed_tokens_enabled" {
  type    = bool
  default = false
}


