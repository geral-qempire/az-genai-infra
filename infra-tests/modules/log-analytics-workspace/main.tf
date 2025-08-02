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

# Call your module from the parent directory
module "log_analytics_workspace" {
  source = "../../../modules/log-analytics-workspace/resource"

  name                = "${var.name_prefix}-law-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.test.name
  location            = var.location
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}

# Simple action group for alerts
resource "azurerm_monitor_action_group" "test" {
  name                = "${var.name_prefix}-ag-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.test.name
  location            = var.location
  short_name          = "TestAG"

  # Email notifications (replace with your email)
  email_receiver {
    name          = "platform-team"
    email_address = "platform-team@example.com"
  }

  tags = var.tags
}

# Deploy the availability alert module
module "availability_alert" {
  source = "../../../modules/log-analytics-workspace/alerts/AvailabilityRate_Query"

  name                = "${var.name_prefix}-alert-availability-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.test.name
  scopes              = [module.log_analytics_workspace.id]
  
  # Alert when availability drops below 95%
  threshold = 95
  
  description = "Test alert for Log Analytics workspace availability monitoring"
  enabled     = true
  
  # Notify the action group when alert fires
  action_group_ids = [azurerm_monitor_action_group.test.id]
}
