resource "azurerm_application_insights" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type     = lower(var.application_type)
  sampling_percentage  = var.sampling_percentage
  daily_data_cap_in_gb = var.daily_data_cap_in_gb
  retention_in_days    = var.retention_days

  tags = var.tags
}
