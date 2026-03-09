########################################
# Resource Group
########################################
output "resource_group_id" {
  description = "ID of the resource group"
  value       = data.azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = data.azurerm_resource_group.this.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = data.azurerm_resource_group.this.location
}

########################################
# Action Group
########################################
output "action_group_id" {
  description = "ID of the action group"
  value       = var.action_group_id != null ? var.action_group_id : data.azurerm_monitor_action_group.this.id
}

output "action_group_name" {
  description = "Name of the action group"
  value       = data.azurerm_monitor_action_group.this.name
}

output "action_group_short_name" {
  description = "Short name of the action group"
  value       = data.azurerm_monitor_action_group.this.short_name
}

########################################
# SQL Database Alerts
########################################
output "sql_db_availability_alert_ids" {
  description = "Map of SQL Database availability alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_availability : k => v.id
  }
}

output "sql_db_availability_alert_names" {
  description = "Map of SQL Database availability alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_availability : k => v.name
  }
}

output "sql_db_storage_alert_ids" {
  description = "Map of SQL Database storage alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_storage : k => v.id
  }
}

output "sql_db_storage_alert_names" {
  description = "Map of SQL Database storage alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_storage : k => v.name
  }
}

output "sql_db_app_cpu_alert_ids" {
  description = "Map of SQL Database app CPU alert IDs (serverless only)"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_app_cpu : k => v.id
  }
}

output "sql_db_app_cpu_alert_names" {
  description = "Map of SQL Database app CPU alert names (serverless only)"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_app_cpu : k => v.name
  }
}

output "sql_db_app_memory_alert_ids" {
  description = "Map of SQL Database app memory alert IDs (serverless only)"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_app_memory : k => v.id
  }
}

output "sql_db_app_memory_alert_names" {
  description = "Map of SQL Database app memory alert names (serverless only)"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_app_memory : k => v.name
  }
}

output "sql_db_instance_cpu_alert_ids" {
  description = "Map of SQL Database instance CPU alert IDs (provisioned only)"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_instance_cpu : k => v.id
  }
}

output "sql_db_instance_cpu_alert_names" {
  description = "Map of SQL Database instance CPU alert names (provisioned only)"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_instance_cpu : k => v.name
  }
}

output "sql_db_instance_memory_alert_ids" {
  description = "Map of SQL Database instance memory alert IDs (provisioned only)"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_instance_memory : k => v.id
  }
}

output "sql_db_instance_memory_alert_names" {
  description = "Map of SQL Database instance memory alert names (provisioned only)"
  value = {
    for k, v in azurerm_monitor_metric_alert.sql_db_instance_memory : k => v.name
  }
}

########################################
# Key Vault Alerts
########################################
output "key_vault_availability_alert_ids" {
  description = "Map of Key Vault availability alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.key_vault_availability : k => v.id
  }
}

output "key_vault_availability_alert_names" {
  description = "Map of Key Vault availability alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.key_vault_availability : k => v.name
  }
}

output "key_vault_saturation_alert_ids" {
  description = "Map of Key Vault saturation alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.key_vault_saturation : k => v.id
  }
}

output "key_vault_saturation_alert_names" {
  description = "Map of Key Vault saturation alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.key_vault_saturation : k => v.name
  }
}

########################################
# Storage Account Alerts
########################################
output "storage_availability_alert_ids" {
  description = "Map of Storage Account availability alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.storage_availability : k => v.id
  }
}

output "storage_availability_alert_names" {
  description = "Map of Storage Account availability alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.storage_availability : k => v.name
  }
}

output "storage_latency_alert_ids" {
  description = "Map of Storage Account latency alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.storage_latency : k => v.id
  }
}

output "storage_latency_alert_names" {
  description = "Map of Storage Account latency alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.storage_latency : k => v.name
  }
}

output "storage_used_capacity_alert_ids" {
  description = "Map of Storage Account used capacity alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.storage_used_capacity : k => v.id
  }
}

output "storage_used_capacity_alert_names" {
  description = "Map of Storage Account used capacity alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.storage_used_capacity : k => v.name
  }
}

########################################
# AI Search Alerts
########################################
output "ai_search_latency_alert_ids" {
  description = "Map of AI Search latency alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_search_latency : k => v.id
  }
}

output "ai_search_latency_alert_names" {
  description = "Map of AI Search latency alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_search_latency : k => v.name
  }
}

output "ai_search_throttled_alert_ids" {
  description = "Map of AI Search throttled queries alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_search_throttled : k => v.id
  }
}

output "ai_search_throttled_alert_names" {
  description = "Map of AI Search throttled queries alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_search_throttled : k => v.name
  }
}

########################################
# AI Services Alerts
########################################
output "ai_services_availability_alert_ids" {
  description = "Map of AI Services availability alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_services_availability : k => v.id
  }
}

output "ai_services_availability_alert_names" {
  description = "Map of AI Services availability alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_services_availability : k => v.name
  }
}

output "ai_services_tokens_alert_ids" {
  description = "Map of AI Services tokens alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_services_tokens : k => v.id
  }
}

output "ai_services_tokens_alert_names" {
  description = "Map of AI Services tokens alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_services_tokens : k => v.name
  }
}

output "ai_services_ttft_alert_ids" {
  description = "Map of AI Services TTFT alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_services_ttft : k => v.id
  }
}

output "ai_services_ttft_alert_names" {
  description = "Map of AI Services TTFT alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_services_ttft : k => v.name
  }
}

output "ai_services_ttlt_alert_ids" {
  description = "Map of AI Services TTLT alert IDs"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_services_ttlt : k => v.id
  }
}

output "ai_services_ttlt_alert_names" {
  description = "Map of AI Services TTLT alert names"
  value = {
    for k, v in azurerm_monitor_metric_alert.ai_services_ttlt : k => v.name
  }
}

########################################
# All Alerts Summary
########################################
output "all_alert_ids" {
  description = "Map of all created alert IDs by type and resource"
  value = {
    sql_db_availability = {
      for k, v in azurerm_monitor_metric_alert.sql_db_availability : k => v.id
    }
    sql_db_storage = {
      for k, v in azurerm_monitor_metric_alert.sql_db_storage : k => v.id
    }
    sql_db_app_cpu = {
      for k, v in azurerm_monitor_metric_alert.sql_db_app_cpu : k => v.id
    }
    sql_db_app_memory = {
      for k, v in azurerm_monitor_metric_alert.sql_db_app_memory : k => v.id
    }
    sql_db_instance_cpu = {
      for k, v in azurerm_monitor_metric_alert.sql_db_instance_cpu : k => v.id
    }
    sql_db_instance_memory = {
      for k, v in azurerm_monitor_metric_alert.sql_db_instance_memory : k => v.id
    }
    key_vault_availability = {
      for k, v in azurerm_monitor_metric_alert.key_vault_availability : k => v.id
    }
    key_vault_saturation = {
      for k, v in azurerm_monitor_metric_alert.key_vault_saturation : k => v.id
    }
    storage_availability = {
      for k, v in azurerm_monitor_metric_alert.storage_availability : k => v.id
    }
    storage_latency = {
      for k, v in azurerm_monitor_metric_alert.storage_latency : k => v.id
    }
    storage_used_capacity = {
      for k, v in azurerm_monitor_metric_alert.storage_used_capacity : k => v.id
    }
    ai_search_latency = {
      for k, v in azurerm_monitor_metric_alert.ai_search_latency : k => v.id
    }
    ai_search_throttled = {
      for k, v in azurerm_monitor_metric_alert.ai_search_throttled : k => v.id
    }
    ai_services_availability = {
      for k, v in azurerm_monitor_metric_alert.ai_services_availability : k => v.id
    }
    ai_services_tokens = {
      for k, v in azurerm_monitor_metric_alert.ai_services_tokens : k => v.id
    }
    ai_services_ttft = {
      for k, v in azurerm_monitor_metric_alert.ai_services_ttft : k => v.id
    }
    ai_services_ttlt = {
      for k, v in azurerm_monitor_metric_alert.ai_services_ttlt : k => v.id
    }
  }
}

output "all_alert_names" {
  description = "Map of all created alert names by type and resource"
  value = {
    sql_db_availability = {
      for k, v in azurerm_monitor_metric_alert.sql_db_availability : k => v.name
    }
    sql_db_storage = {
      for k, v in azurerm_monitor_metric_alert.sql_db_storage : k => v.name
    }
    sql_db_app_cpu = {
      for k, v in azurerm_monitor_metric_alert.sql_db_app_cpu : k => v.name
    }
    sql_db_app_memory = {
      for k, v in azurerm_monitor_metric_alert.sql_db_app_memory : k => v.name
    }
    sql_db_instance_cpu = {
      for k, v in azurerm_monitor_metric_alert.sql_db_instance_cpu : k => v.name
    }
    sql_db_instance_memory = {
      for k, v in azurerm_monitor_metric_alert.sql_db_instance_memory : k => v.name
    }
    key_vault_availability = {
      for k, v in azurerm_monitor_metric_alert.key_vault_availability : k => v.name
    }
    key_vault_saturation = {
      for k, v in azurerm_monitor_metric_alert.key_vault_saturation : k => v.name
    }
    storage_availability = {
      for k, v in azurerm_monitor_metric_alert.storage_availability : k => v.name
    }
    storage_latency = {
      for k, v in azurerm_monitor_metric_alert.storage_latency : k => v.name
    }
    storage_used_capacity = {
      for k, v in azurerm_monitor_metric_alert.storage_used_capacity : k => v.name
    }
    ai_search_latency = {
      for k, v in azurerm_monitor_metric_alert.ai_search_latency : k => v.name
    }
    ai_search_throttled = {
      for k, v in azurerm_monitor_metric_alert.ai_search_throttled : k => v.name
    }
    ai_services_availability = {
      for k, v in azurerm_monitor_metric_alert.ai_services_availability : k => v.name
    }
    ai_services_tokens = {
      for k, v in azurerm_monitor_metric_alert.ai_services_tokens : k => v.name
    }
    ai_services_ttft = {
      for k, v in azurerm_monitor_metric_alert.ai_services_ttft : k => v.name
    }
    ai_services_ttlt = {
      for k, v in azurerm_monitor_metric_alert.ai_services_ttlt : k => v.name
    }
  }
}
