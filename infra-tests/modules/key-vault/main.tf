# Random suffix to avoid name collisions across repeated test runs
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  lower   = true
  special = false
}

# Simple resource group for the test
resource "azurerm_resource_group" "test" {
  name     = "rg-${var.location}-${var.name_prefix}"
  location = var.location

  tags = var.tags
}

# Get current client configuration for Key Vault access
data "azurerm_client_config" "current" {}

# Deploy the Key Vault using our module
module "key_vault" {
  source = "../../../modules/key-vault/resources"

  name                        = "${var.name_prefix}-kv-${random_string.suffix.result}"
  resource_group_name         = azurerm_resource_group.test.name
  location                    = var.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  sku                         = var.sku
  network_rules_bypass        = var.network_rules_bypass
  tags                        = var.tags
}

# Simple action group for testing alerts
resource "azurerm_monitor_action_group" "test" {
  name                = "${var.name_prefix}-ag-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.test.name
  location            = "global"  # Action groups are global
  short_name          = "TestAG"

  # Email notifications (replace with your email)
  email_receiver {
    name          = "platform-team"
    email_address = var.alert_email_address
  }

  tags = var.tags
}

# Deploy the Key Vault availability alert using our module
module "key_vault_availability_alert" {
  source = "../../../modules/key-vault/alerts/Availability"

  name                = "${var.name_prefix}-alert-kv-availability-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.test.name
  scopes              = [module.key_vault.id]
  
  # Alert when availability drops below the specified threshold
  threshold = var.availability_threshold
  
  description = "Test alert for Key Vault availability monitoring"
  enabled     = true
  
  # Notify the action group when alert fires
  action_group_ids = [azurerm_monitor_action_group.test.id]
}

# Deploy the Key Vault saturation alert using our module
module "key_vault_saturation_alert" {
  source = "../../../modules/key-vault/alerts/SaturationShoebox"

  name                = "${var.name_prefix}-alert-kv-saturation-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.test.name
  scopes              = [module.key_vault.id]
  
  # Alert when saturation exceeds the specified threshold
  threshold = var.saturation_threshold
  
  description = "Test alert for Key Vault capacity saturation monitoring"
  enabled     = true
  
  # Notify the action group when alert fires
  action_group_ids = [azurerm_monitor_action_group.test.id]
}

# Deploy the Key Vault latency alert using our module
module "key_vault_latency_alert" {
  source = "../../../modules/key-vault/alerts/ServiceApiLatency"

  name                = "${var.name_prefix}-alert-kv-latency-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.test.name
  scopes              = [module.key_vault.id]
  
  # Alert when latency exceeds the specified threshold
  threshold = var.latency_threshold
  
  description = "Test alert for Key Vault API latency monitoring"
  enabled     = true
  
  # Notify the action group when alert fires
  action_group_ids = [azurerm_monitor_action_group.test.id]
} 