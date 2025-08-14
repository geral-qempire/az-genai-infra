output "resource_group_name" {
  value       = module.log_template.resource_group_name
  description = "Name of the created resource group."
}

output "resource_group_id" {
  value       = module.log_template.resource_group_id
  description = "ID of the created resource group."
}

output "log_analytics_workspace_id" {
  value       = module.log_template.log_analytics_workspace_id
  description = "ID of the Log Analytics workspace."
}

output "log_analytics_workspace_name" {
  value       = module.log_template.log_analytics_workspace_name
  description = "Name of the Log Analytics workspace."
}


