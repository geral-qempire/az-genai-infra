provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
  
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Separate provider for DNS zone subscription
provider "azurerm" {
  alias = "dns"
  features {}
  
  subscription_id = var.dns_zone_subscription_id
  tenant_id       = var.tenant_id
} 