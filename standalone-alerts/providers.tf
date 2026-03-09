########################################
# Azure Provider Configuration
########################################

provider "azurerm" {
  features {}
  
  # Use provided subscription and tenant IDs
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  
  # Optional: Use service principal authentication if client_id and client_secret are provided
  client_id     = var.client_id
  client_secret = var.client_secret
}
