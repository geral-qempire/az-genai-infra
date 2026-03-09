output "resource_group_name" {
  description = "Name of the created DNS resource group."
  value       = module.private_dns_zones.resource_group_name
}

output "resource_group_id" {
  description = "ID of the created DNS resource group."
  value       = module.private_dns_zones.resource_group_id
}

output "all_dns_zone_ids" {
  description = "Map of all private DNS zone IDs keyed by service name."
  value       = module.private_dns_zones.all_dns_zone_ids
}

output "sql_dns_zone_id" {
  description = "ID of the privatelink.database.windows.net DNS zone."
  value       = module.private_dns_zones.sql_dns_zone_id
}

output "key_vault_dns_zone_id" {
  description = "ID of the privatelink.vaultcore.azure.net DNS zone."
  value       = module.private_dns_zones.key_vault_dns_zone_id
}

output "storage_blob_dns_zone_id" {
  description = "ID of the privatelink.blob.core.windows.net DNS zone."
  value       = module.private_dns_zones.storage_blob_dns_zone_id
}

output "storage_file_dns_zone_id" {
  description = "ID of the privatelink.file.core.windows.net DNS zone."
  value       = module.private_dns_zones.storage_file_dns_zone_id
}

output "storage_queue_dns_zone_id" {
  description = "ID of the privatelink.queue.core.windows.net DNS zone."
  value       = module.private_dns_zones.storage_queue_dns_zone_id
}

output "storage_table_dns_zone_id" {
  description = "ID of the privatelink.table.core.windows.net DNS zone."
  value       = module.private_dns_zones.storage_table_dns_zone_id
}

output "storage_dfs_dns_zone_id" {
  description = "ID of the privatelink.dfs.core.windows.net DNS zone."
  value       = module.private_dns_zones.storage_dfs_dns_zone_id
}

output "azureml_api_dns_zone_id" {
  description = "ID of the privatelink.api.azureml.ms DNS zone."
  value       = module.private_dns_zones.azureml_api_dns_zone_id
}

output "azureml_notebooks_dns_zone_id" {
  description = "ID of the privatelink.notebooks.azure.net DNS zone."
  value       = module.private_dns_zones.azureml_notebooks_dns_zone_id
}

output "cognitive_services_dns_zone_id" {
  description = "ID of the privatelink.cognitiveservices.azure.com DNS zone."
  value       = module.private_dns_zones.cognitive_services_dns_zone_id
}
