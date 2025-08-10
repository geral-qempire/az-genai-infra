provider "azurerm" {
  features {}
  subscription_id = var.infra_subscription_id
}

provider "azurerm" {
  alias           = "dns"
  features        {}
  subscription_id = var.dns_subscription_id
}




