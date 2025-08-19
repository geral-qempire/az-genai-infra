output "storage_account_id" {
  value       = module.storage_account.storage_account_id
  description = "The ID of the Storage Account."
}

output "storage_account_name" {
  value       = module.storage_account.storage_account_name
  description = "The Name of the Storage Account."
}


output "key_vault_id" {
  value       = module.key_vault.id
  description = "The ID of the Key Vault."
}

output "key_vault_name" {
  value       = module.key_vault.name
  description = "The name of the Key Vault."
}


output "ai_hub_id" {
  value       = module.ai_hub.ai_hub_id
  description = "The ID of the AI Hub."
}

output "ai_hub_name" {
  value       = module.ai_hub.ai_hub_name
  description = "The Name of the AI Hub."
}


output "ai_search_id" {
  value       = module.ai_search.search_service_id
  description = "The ID of the AI Search Service."
}

output "ai_search_name" {
  value       = module.ai_search.search_service_name
  description = "The Name of the AI Search Service."
}

output "ai_search_connection_id" {
  value       = module.ai_search_hub_connection.connection_id
  description = "The ID of the AI Search connection created under the AI Project."
}

output "ai_search_connection_name" {
  value       = module.ai_search_hub_connection.connection_name
  description = "The Name of the AI Search connection created under the AI Project."
}

output "blob_connection_id" {
  value       = module.blob_hub_connection.connection_id
  description = "The ID of the API Key connection created under the AI Project."
}

output "blob_connection_name" {
  value       = module.blob_hub_connection.connection_name
  description = "The Name of the API Key connection created under the AI Project."
}

output "ai_services_connection_id" {
  value       = module.ai_services_hub_connection.connection_id
  description = "The ID of the AI Services connection created under the AI Project."
}

output "ai_services_connection_name" {
  value       = module.ai_services_hub_connection.connection_name
  description = "The Name of the AI Services connection created under the AI Project."
}

