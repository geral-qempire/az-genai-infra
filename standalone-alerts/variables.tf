########################################
# Basic Configuration
########################################
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group for alerts"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to alert resources"
}

########################################
# Action Group Configuration
########################################
variable "action_group_name" {
  type        = string
  description = "Name of the existing action group"
}

variable "action_group_id" {
  type        = string
  default     = null
  description = "ID of the action group to use for alerts. If null, will use the action group loaded by name. If provided, will override the loaded action group."
}

########################################
# Azure Authentication (Optional)
########################################
variable "subscription_id" {
  type        = string
  default     = null
  description = "Azure subscription ID (optional - will use default if not provided)"
}

variable "tenant_id" {
  type        = string
  default     = null
  description = "Azure tenant ID (optional - will use default if not provided)"
}

variable "client_id" {
  type        = string
  default     = null
  description = "Azure client ID for service principal authentication (optional)"
  sensitive   = true
}

variable "client_secret" {
  type        = string
  default     = null
  description = "Azure client secret for service principal authentication (optional)"
  sensitive   = true
}

########################################
# Resource IDs
########################################
variable "sql_database_ids" {
  type        = map(string)
  default     = {}
  description = "Map of SQL Database IDs (key: name, value: resource ID)"
}

variable "sql_database_serverless_ids" {
  type        = map(string)
  default     = {}
  description = "Map of SQL Database Serverless IDs (key: name, value: resource ID)"
}

variable "sql_database_provisioned_ids" {
  type        = map(string)
  default     = {}
  description = "Map of SQL Database Provisioned IDs (key: name, value: resource ID)"
}

variable "key_vault_ids" {
  type        = map(string)
  default     = {}
  description = "Map of Key Vault IDs (key: name, value: resource ID)"
}

variable "storage_account_ids" {
  type        = map(string)
  default     = {}
  description = "Map of Storage Account IDs (key: name, value: resource ID)"
}

variable "ai_search_ids" {
  type        = map(string)
  default     = {}
  description = "Map of AI Search Service IDs (key: name, value: resource ID)"
}

variable "ai_services_ids" {
  type        = map(string)
  default     = {}
  description = "Map of AI Services IDs (key: name, value: resource ID)"
}

########################################
# SQL Database Alert Configuration
########################################

# Availability Alert
variable "sql_db_availability_enabled" {
  type        = bool
  default     = true
  description = "Enable SQL Database availability alerts"
}

variable "sql_db_availability_threshold" {
  type        = number
  default     = 90
  description = "Availability threshold percentage"
}

variable "sql_db_availability_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4)"
}

variable "sql_db_availability_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "sql_db_availability_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "sql_db_availability_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "sql_db_availability_operator" {
  type        = string
  default     = "LessThan"
  description = "Comparison operator"
}

variable "sql_db_availability_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "sql_db_availability_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for availability alerts"
}

# Storage Alert
variable "sql_db_storage_enabled" {
  type        = bool
  default     = true
  description = "Enable SQL Database storage alerts"
}

variable "sql_db_storage_threshold" {
  type        = number
  default     = 80
  description = "Storage threshold percentage"
}

variable "sql_db_storage_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4)"
}

variable "sql_db_storage_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "sql_db_storage_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "sql_db_storage_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "sql_db_storage_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "sql_db_storage_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "sql_db_storage_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for storage alerts"
}

# App CPU Alert (Serverless)
variable "sql_db_app_cpu_enabled" {
  type        = bool
  default     = true
  description = "Enable SQL Database app CPU alerts (serverless only)"
}

variable "sql_db_app_cpu_threshold" {
  type        = number
  default     = 80
  description = "App CPU threshold percentage"
}

variable "sql_db_app_cpu_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4)"
}

variable "sql_db_app_cpu_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "sql_db_app_cpu_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "sql_db_app_cpu_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "sql_db_app_cpu_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "sql_db_app_cpu_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "sql_db_app_cpu_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for app CPU alerts"
}

# App Memory Alert (Serverless)
variable "sql_db_app_memory_enabled" {
  type        = bool
  default     = true
  description = "Enable SQL Database app memory alerts (serverless only)"
}

variable "sql_db_app_memory_threshold" {
  type        = number
  default     = 90
  description = "App memory threshold percentage"
}

variable "sql_db_app_memory_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4)"
}

variable "sql_db_app_memory_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "sql_db_app_memory_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "sql_db_app_memory_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "sql_db_app_memory_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "sql_db_app_memory_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "sql_db_app_memory_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for app memory alerts"
}

# SQL Instance CPU Alert (Provisioned)
variable "sql_db_instance_cpu_enabled" {
  type        = bool
  default     = true
  description = "Enable SQL Database instance CPU alerts (provisioned only)"
}

variable "sql_db_instance_cpu_threshold" {
  type        = number
  default     = 70
  description = "Instance CPU threshold percentage"
}

variable "sql_db_instance_cpu_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4)"
}

variable "sql_db_instance_cpu_frequency" {
  type        = string
  default     = "PT5M"
  description = "Evaluation frequency"
}

variable "sql_db_instance_cpu_window_size" {
  type        = string
  default     = "PT15M"
  description = "Time window for evaluation"
}

variable "sql_db_instance_cpu_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "sql_db_instance_cpu_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "sql_db_instance_cpu_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "sql_db_instance_cpu_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for instance CPU alerts"
}

# SQL Instance Memory Alert (Provisioned)
variable "sql_db_instance_memory_enabled" {
  type        = bool
  default     = true
  description = "Enable SQL Database instance memory alerts (provisioned only)"
}

variable "sql_db_instance_memory_threshold" {
  type        = number
  default     = 90
  description = "Instance memory threshold percentage"
}

variable "sql_db_instance_memory_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4)"
}

variable "sql_db_instance_memory_frequency" {
  type        = string
  default     = "PT5M"
  description = "Evaluation frequency"
}

variable "sql_db_instance_memory_window_size" {
  type        = string
  default     = "PT15M"
  description = "Time window for evaluation"
}

variable "sql_db_instance_memory_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "sql_db_instance_memory_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "sql_db_instance_memory_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "sql_db_instance_memory_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for instance memory alerts"
}

########################################
# Key Vault Alert Configuration
########################################

# Availability Alert
variable "key_vault_availability_enabled" {
  type        = bool
  default     = true
  description = "Enable Key Vault availability alerts"
}

variable "key_vault_availability_threshold" {
  type        = number
  default     = 90
  description = "Availability threshold percentage"
}

variable "key_vault_availability_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4)"
}

variable "key_vault_availability_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "key_vault_availability_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "key_vault_availability_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "key_vault_availability_operator" {
  type        = string
  default     = "LessThan"
  description = "Comparison operator"
}

variable "key_vault_availability_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "key_vault_availability_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for availability alerts"
}

# Saturation Alert
variable "key_vault_saturation_enabled" {
  type        = bool
  default     = true
  description = "Enable Key Vault saturation alerts"
}

variable "key_vault_saturation_threshold" {
  type        = number
  default     = 75
  description = "Saturation threshold percentage"
}

variable "key_vault_saturation_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4)"
}

variable "key_vault_saturation_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "key_vault_saturation_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "key_vault_saturation_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "key_vault_saturation_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "key_vault_saturation_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "key_vault_saturation_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for saturation alerts"
}

########################################
# Storage Account Alert Configuration
########################################

# Availability Alert
variable "storage_availability_enabled" {
  type        = bool
  default     = true
  description = "Enable Storage Account availability alerts"
}

variable "storage_availability_threshold" {
  type        = number
  default     = 90
  description = "Availability threshold percentage"
}

variable "storage_availability_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4)"
}

variable "storage_availability_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "storage_availability_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "storage_availability_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "storage_availability_operator" {
  type        = string
  default     = "LessThan"
  description = "Comparison operator"
}

variable "storage_availability_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "storage_availability_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for availability alerts"
}

# Latency Alert
variable "storage_latency_enabled" {
  type        = bool
  default     = true
  description = "Enable Storage Account latency alerts"
}

variable "storage_latency_threshold" {
  type        = number
  default     = 500
  description = "Latency threshold in milliseconds"
}

variable "storage_latency_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4)"
}

variable "storage_latency_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "storage_latency_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "storage_latency_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "storage_latency_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "storage_latency_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "storage_latency_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for latency alerts"
}

# Used Capacity Alert
variable "storage_used_capacity_enabled" {
  type        = bool
  default     = true
  description = "Enable Storage Account used capacity alerts"
}

variable "storage_used_capacity_threshold" {
  type        = number
  default     = 1000000000000
  description = "Used capacity threshold in bytes"
}

variable "storage_used_capacity_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4)"
}

variable "storage_used_capacity_frequency" {
  type        = string
  default     = "PT1H"
  description = "Evaluation frequency"
}

variable "storage_used_capacity_window_size" {
  type        = string
  default     = "PT1H"
  description = "Time window for evaluation"
}

variable "storage_used_capacity_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "storage_used_capacity_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "storage_used_capacity_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "storage_used_capacity_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for used capacity alerts"
}

########################################
# AI Search Alert Configuration
########################################

# Latency Alert
variable "ai_search_latency_enabled" {
  type        = bool
  default     = true
  description = "Enable AI Search latency alerts"
}

variable "ai_search_latency_threshold" {
  type        = number
  default     = 1000
  description = "Latency threshold in milliseconds"
}

variable "ai_search_latency_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4)"
}

variable "ai_search_latency_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "ai_search_latency_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "ai_search_latency_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "ai_search_latency_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "ai_search_latency_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "ai_search_latency_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for latency alerts"
}

# Throttled Queries Alert
variable "ai_search_throttled_enabled" {
  type        = bool
  default     = true
  description = "Enable AI Search throttled queries alerts"
}

variable "ai_search_throttled_threshold" {
  type        = number
  default     = 5
  description = "Throttled queries threshold percentage"
}

variable "ai_search_throttled_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4)"
}

variable "ai_search_throttled_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "ai_search_throttled_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "ai_search_throttled_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "ai_search_throttled_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "ai_search_throttled_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "ai_search_throttled_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for throttled queries alerts"
}

########################################
# AI Services Alert Configuration
########################################

# Availability Alert
variable "ai_services_availability_enabled" {
  type        = bool
  default     = true
  description = "Enable AI Services availability alerts"
}

variable "ai_services_availability_threshold" {
  type        = number
  default     = 90
  description = "Availability threshold percentage"
}

variable "ai_services_availability_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4)"
}

variable "ai_services_availability_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "ai_services_availability_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "ai_services_availability_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "ai_services_availability_operator" {
  type        = string
  default     = "LessThan"
  description = "Comparison operator"
}

variable "ai_services_availability_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "ai_services_availability_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for availability alerts"
}

variable "ai_services_availability_model_deployment_names" {
  type        = list(string)
  default     = []
  description = "List of model deployment names for availability alerts (empty = all)"
}

# Tokens Alert
variable "ai_services_tokens_enabled" {
  type        = bool
  default     = true
  description = "Enable AI Services tokens alerts"
}

variable "ai_services_tokens_threshold" {
  type        = number
  default     = 10000000
  description = "Tokens threshold"
}

variable "ai_services_tokens_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4)"
}

variable "ai_services_tokens_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "ai_services_tokens_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "ai_services_tokens_aggregation" {
  type        = string
  default     = "Total"
  description = "Metric aggregation type"
}

variable "ai_services_tokens_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "ai_services_tokens_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "ai_services_tokens_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for tokens alerts"
}

variable "ai_services_tokens_model_deployment_names" {
  type        = list(string)
  default     = []
  description = "List of model deployment names for tokens alerts (empty = all)"
}

# TTFT Alert
variable "ai_services_ttft_enabled" {
  type        = bool
  default     = true
  description = "Enable AI Services TTFT alerts"
}

variable "ai_services_ttft_threshold" {
  type        = number
  default     = 5
  description = "TTFT threshold in milliseconds"
}

variable "ai_services_ttft_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4)"
}

variable "ai_services_ttft_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "ai_services_ttft_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "ai_services_ttft_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "ai_services_ttft_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "ai_services_ttft_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "ai_services_ttft_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for TTFT alerts"
}

variable "ai_services_ttft_model_deployment_names" {
  type        = list(string)
  default     = []
  description = "List of model deployment names for TTFT alerts (empty = all)"
}

# TTLT Alert
variable "ai_services_ttlt_enabled" {
  type        = bool
  default     = true
  description = "Enable AI Services TTLT alerts"
}

variable "ai_services_ttlt_threshold" {
  type        = number
  default     = 5
  description = "TTLT threshold in milliseconds"
}

variable "ai_services_ttlt_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4)"
}

variable "ai_services_ttlt_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency"
}

variable "ai_services_ttlt_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for evaluation"
}

variable "ai_services_ttlt_aggregation" {
  type        = string
  default     = "Average"
  description = "Metric aggregation type"
}

variable "ai_services_ttlt_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Comparison operator"
}

variable "ai_services_ttlt_auto_mitigate" {
  type        = bool
  default     = true
  description = "Enable auto-mitigation"
}

variable "ai_services_ttlt_action_group_ids" {
  type        = list(string)
  default     = []
  description = "List of action group IDs for TTLT alerts"
}

variable "ai_services_ttlt_model_deployment_names" {
  type        = list(string)
  default     = []
  description = "List of model deployment names for TTLT alerts (empty = all)"
}
