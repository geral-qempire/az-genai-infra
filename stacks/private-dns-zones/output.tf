########################################
# Resource Group
########################################
output "resource_group_name" {
  description = "Name of the created DNS resource group."
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "ID of the created DNS resource group."
  value       = azurerm_resource_group.this.id
}

########################################
# SQL Server
########################################
output "sql_dns_zone_id" {
  description = "ID of the privatelink.database.windows.net DNS zone."
  value       = azurerm_private_dns_zone.sql.id
}

output "sql_dns_zone_name" {
  description = "Name of the SQL Server private DNS zone."
  value       = azurerm_private_dns_zone.sql.name
}

########################################
# Key Vault
########################################
output "key_vault_dns_zone_id" {
  description = "ID of the privatelink.vaultcore.azure.net DNS zone."
  value       = azurerm_private_dns_zone.key_vault.id
}

output "key_vault_dns_zone_name" {
  description = "Name of the Key Vault private DNS zone."
  value       = azurerm_private_dns_zone.key_vault.name
}

########################################
# Storage Account
########################################
output "storage_blob_dns_zone_id" {
  description = "ID of the privatelink.blob.core.windows.net DNS zone."
  value       = azurerm_private_dns_zone.storage_blob.id
}

output "storage_blob_dns_zone_name" {
  description = "Name of the Storage blob private DNS zone."
  value       = azurerm_private_dns_zone.storage_blob.name
}

output "storage_file_dns_zone_id" {
  description = "ID of the privatelink.file.core.windows.net DNS zone."
  value       = azurerm_private_dns_zone.storage_file.id
}

output "storage_file_dns_zone_name" {
  description = "Name of the Storage file private DNS zone."
  value       = azurerm_private_dns_zone.storage_file.name
}

output "storage_queue_dns_zone_id" {
  description = "ID of the privatelink.queue.core.windows.net DNS zone."
  value       = azurerm_private_dns_zone.storage_queue.id
}

output "storage_queue_dns_zone_name" {
  description = "Name of the Storage queue private DNS zone."
  value       = azurerm_private_dns_zone.storage_queue.name
}

output "storage_table_dns_zone_id" {
  description = "ID of the privatelink.table.core.windows.net DNS zone."
  value       = azurerm_private_dns_zone.storage_table.id
}

output "storage_table_dns_zone_name" {
  description = "Name of the Storage table private DNS zone."
  value       = azurerm_private_dns_zone.storage_table.name
}

output "storage_dfs_dns_zone_id" {
  description = "ID of the privatelink.dfs.core.windows.net DNS zone."
  value       = azurerm_private_dns_zone.storage_dfs.id
}

output "storage_dfs_dns_zone_name" {
  description = "Name of the Storage DFS private DNS zone."
  value       = azurerm_private_dns_zone.storage_dfs.name
}

########################################
# AI Hub + AI Search (Azure ML)
########################################
output "azureml_api_dns_zone_id" {
  description = "ID of the privatelink.api.azureml.ms DNS zone."
  value       = azurerm_private_dns_zone.azureml_api.id
}

output "azureml_api_dns_zone_name" {
  description = "Name of the Azure ML API private DNS zone."
  value       = azurerm_private_dns_zone.azureml_api.name
}

output "azureml_notebooks_dns_zone_id" {
  description = "ID of the privatelink.notebooks.azure.net DNS zone."
  value       = azurerm_private_dns_zone.azureml_notebooks.id
}

output "azureml_notebooks_dns_zone_name" {
  description = "Name of the Azure ML Notebooks private DNS zone."
  value       = azurerm_private_dns_zone.azureml_notebooks.name
}

########################################
# AI Services (Cognitive Services)
########################################
output "cognitive_services_dns_zone_id" {
  description = "ID of the privatelink.cognitiveservices.azure.com DNS zone."
  value       = azurerm_private_dns_zone.cognitive_services.id
}

output "cognitive_services_dns_zone_name" {
  description = "Name of the Cognitive Services private DNS zone."
  value       = azurerm_private_dns_zone.cognitive_services.name
}

########################################
# Convenience map of all zone IDs
########################################
output "all_dns_zone_ids" {
  description = "Map of all private DNS zone IDs keyed by service name."
  value = {
    sql                  = azurerm_private_dns_zone.sql.id
    key_vault            = azurerm_private_dns_zone.key_vault.id
    storage_blob         = azurerm_private_dns_zone.storage_blob.id
    storage_file         = azurerm_private_dns_zone.storage_file.id
    storage_queue        = azurerm_private_dns_zone.storage_queue.id
    storage_table        = azurerm_private_dns_zone.storage_table.id
    storage_dfs          = azurerm_private_dns_zone.storage_dfs.id
    azureml_api          = azurerm_private_dns_zone.azureml_api.id
    azureml_notebooks    = azurerm_private_dns_zone.azureml_notebooks.id
    cognitive_services   = azurerm_private_dns_zone.cognitive_services.id
  }
}
