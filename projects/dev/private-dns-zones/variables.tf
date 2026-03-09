# Subscription
variable "infra_subscription_id" { type = string }

# Core
variable "service_prefix" { type = string }
variable "location" { type = string }

# Tags
variable "tags" {
  type    = map(string)
  default = {}
}
