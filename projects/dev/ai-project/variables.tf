# Subscriptions
variable "infra_subscription_id" { type = string }
variable "dns_subscription_id" { type = string }

# Tags
variable "tags" { type = map(string) }

# Setup
variable "service_prefix" { type = string }
variable "location" { type = string }
variable "environment" { type = string }

# Existing AI Hub
variable "hub_resource_group_name" { type = string }
variable "hub_name" { type = string }

# AI Project
variable "ai_project_location" {
  type    = string
  default = null
}
variable "friendly_name" {
  type    = string
  default = ""
}

# AI Services location override
variable "ai_services_location" {
  type    = string
  default = null
}

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

# Network
variable "subnet_name" { type = string }
variable "vnet_name" { type = string }
variable "dns_resource_group_name" { type = string }
variable "vnet_resource_group_name" { type = string }

# AI Services
variable "ai_services_sku_name" {
  type    = string
  default = "S0"
}
variable "ai_services_model_deployment_names" {
  type    = list(string)
  default = []
}

# AI Services Alerts
variable "ai_services_alert_availability_rate_enabled" {
  type    = bool
  default = true
}
variable "ai_services_alert_normalized_ttft_enabled" {
  type    = bool
  default = true
}
variable "ai_services_alert_ttlt_enabled" {
  type    = bool
  default = true
}
variable "ai_services_alert_processed_tokens_enabled" {
  type    = bool
  default = true
}

# Action Group
variable "action_group_id" {
  type    = string
  default = null
}
variable "action_group_emails" {
  type    = list(string)
  default = []
}
