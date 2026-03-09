# Subscription
variable "infra_subscription_id" { type = string }

# Core
variable "environment" { type = string }
variable "service_prefix" { type = string }
variable "location" { type = string }

# Log Analytics
variable "sku" {
  type    = string
  default = "PerGB2018"
}
variable "retention_in_days" {
  type    = number
  default = 30
}
variable "daily_quota_gb" {
  type    = number
  default = -1
}

# Tags
variable "tags" {
  type    = map(string)
  default = {}
}
