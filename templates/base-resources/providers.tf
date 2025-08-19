provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    application_insights {
      disable_generated_rule = true
    }
  }
  subscription_id = var.infra_subscription_id
}

provider "azurerm" {
  alias           = "dns"
  subscription_id = var.dns_subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


