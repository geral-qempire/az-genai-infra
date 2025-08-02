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
module "application_insights" {
  source = "../../../modules/application-insights/resource"

  name                  = "${var.name_prefix}-ai-${random_string.suffix.result}"
  resource_group_name   = azurerm_resource_group.test.name
  location              = var.location
  application_type      = var.application_type
  retention_days        = var.retention_days
  sampling_percentage   = var.sampling_percentage
  daily_data_cap_in_gb  = var.daily_data_cap_in_gb
  tags                  = var.tags
} 