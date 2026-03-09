# Subscription
variable "infra_subscription_id" { type = string }

# Core
variable "service_prefix" { type = string }
variable "location" { type = string }

# VNet
variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

# Subnets
variable "subnet_address_prefixes" {
  type = map(string)
  default = {
    dev = "10.0.1.0/24"
    qua = "10.0.2.0/24"
    prd = "10.0.3.0/24"
  }
}

# Tags
variable "tags" {
  type    = map(string)
  default = {}
}
