variable "server_id" {
  type        = string
  description = "The ID of the parent Azure SQL Server."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the SQL Database should exist."
}

variable "name" {
  type        = string
  description = "The name of the SQL Database."
}

variable "sku_name" {
  type        = string
  default     = "S0"
  description = "Specifies the SKU Name for this SQL Database (e.g., GP_S_Gen5_2, HS_Gen5_2, S0, P1)."
}

variable "collation" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "Specifies the collation of the SQL Database."
}

variable "zone_redundant" {
  type        = bool
  default     = false
  description = "Specifies whether or not this database is zone redundant."
}

variable "min_capacity" {
  type        = number
  default     = null
  description = "Optional minimum capacity (vCores) for Serverless SKUs (e.g., GP_S_*). Omit or set null for non-Serverless SKUs."
}

variable "auto_pause_delay_in_minutes" {
  type        = number
  default     = null
  description = "Optional auto pause delay in minutes for Serverless SKUs. Set null to omit."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}

# Backup settings (PITR and LTR)
variable "pitr_days" {
  type        = number
  default     = 7
  description = "Point-in-time restore retention days (PITR)."
}

variable "backup_interval_in_hours" {
  type        = number
  default     = 0
  description = "Optional differential backup interval in hours for short term retention. Set to 0 to omit. Provider limits apply (e.g., Hyperscale only, typically 12 or 24)."
}

variable "weekly_ltr_weeks" {
  type        = number
  default     = 0
  description = "Weekly LTR retention in weeks. Set 0 to disable."
}

variable "monthly_ltr_months" {
  type        = number
  default     = 0
  description = "Monthly LTR retention in months. Set 0 to disable."
}

variable "yearly_ltr_years" {
  type        = number
  default     = 0
  description = "Yearly LTR retention in years. Set 0 to disable."
}


### Identity

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default     = null
  description = "Optional identity configuration. Possible types: UserAssigned. If not set, no identity will be assigned."
  validation {
    condition     = var.identity == null || contains(["UserAssigned"], var.identity.type)
    error_message = "Possible values for identity.type are UserAssigned"
  }
}

variable "is_serverless" {
  type        = bool
  default     = true
  description = "Whether the SQL Database is using a serverless SKU (GP_S_*). Controls which alerts are available."
}

########################################
# Alerts - Availability (Common)
########################################

variable "enable_availability_alert" {
  type        = bool
  default     = true
  description = "Enable the availability metric alert."
}

variable "availability_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the availability alert. Defaults to alrt-avail-<resource-name>."
}

variable "availability_alert_threshold" {
  type        = number
  default     = 90
  description = "Availability threshold percentage. Alert fires when below this value."
}

variable "availability_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the availability alert. Auto-generated if not provided."
}

variable "availability_alert_severity" {
  type        = number
  default     = 1
  description = "Alert severity (0-4). Default is 1."
}

variable "availability_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the availability alert is enabled."
}

variable "availability_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the availability alert should auto mitigate when conditions clear."
}

variable "availability_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the availability alert. Default PT1M."
}

variable "availability_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the availability alert. Default PT5M."
}

variable "availability_alert_operator" {
  type        = string
  default     = "LessThan"
  description = "Operator for the availability alert criteria."
}

variable "availability_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the availability alert criteria."
}

variable "availability_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the availability alert."
}

########################################
# Alerts - Storage (Common)
########################################

variable "enable_storage_alert" {
  type        = bool
  default     = true
  description = "Enable the storage_percent metric alert."
}

variable "storage_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the storage alert. Defaults to alrt-stor-<resource-name>."
}

variable "storage_alert_threshold" {
  type        = number
  default     = 80
  description = "Storage percent threshold. Alert fires when above this value."
}

variable "storage_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the storage alert. Auto-generated if not provided."
}

variable "storage_alert_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4). Default is 3."
}

variable "storage_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the storage alert is enabled."
}

variable "storage_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the storage alert should auto mitigate when conditions clear."
}

variable "storage_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the storage alert. Default PT1M."
}

variable "storage_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the storage alert. Default PT5M."
}

variable "storage_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the storage alert criteria."
}

variable "storage_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the storage alert criteria."
}

variable "storage_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the storage alert."
}

########################################
# Alerts - App CPU (Serverless Only)
########################################

variable "enable_app_cpu_alert" {
  type        = bool
  default     = true
  description = "Enable the app_cpu_percent metric alert (serverless SKUs only)."
}

variable "app_cpu_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the app CPU alert. Defaults to alrt-cpu-<resource-name>."
}

variable "app_cpu_alert_threshold" {
  type        = number
  default     = 80
  description = "App CPU percent threshold. Alert fires when above this value."
}

variable "app_cpu_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the app CPU alert. Auto-generated if not provided."
}

variable "app_cpu_alert_severity" {
  type        = number
  default     = 2
  description = "Alert severity (0-4). Default is 2."
}

variable "app_cpu_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the app CPU alert is enabled."
}

variable "app_cpu_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the app CPU alert should auto mitigate when conditions clear."
}

variable "app_cpu_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the app CPU alert. Default PT1M."
}

variable "app_cpu_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the app CPU alert. Default PT5M."
}

variable "app_cpu_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the app CPU alert criteria."
}

variable "app_cpu_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the app CPU alert criteria."
}

variable "app_cpu_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the app CPU alert."
}

########################################
# Alerts - App Memory (Serverless Only)
########################################

variable "enable_app_memory_alert" {
  type        = bool
  default     = true
  description = "Enable the app_memory_percent metric alert (serverless SKUs only)."
}

variable "app_memory_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the app memory alert. Defaults to alrt-mem-<resource-name>."
}

variable "app_memory_alert_threshold" {
  type        = number
  default     = 90
  description = "App memory percent threshold. Alert fires when above this value."
}

variable "app_memory_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the app memory alert. Auto-generated if not provided."
}

variable "app_memory_alert_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4). Default is 3."
}

variable "app_memory_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the app memory alert is enabled."
}

variable "app_memory_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the app memory alert should auto mitigate when conditions clear."
}

variable "app_memory_alert_frequency" {
  type        = string
  default     = "PT1M"
  description = "Evaluation frequency for the app memory alert. Default PT1M."
}

variable "app_memory_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the app memory alert. Default PT5M."
}

variable "app_memory_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the app memory alert criteria."
}

variable "app_memory_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the app memory alert criteria."
}

variable "app_memory_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the app memory alert."
}

########################################
# Alerts - SQL Instance CPU (Non-Serverless Only)
########################################

variable "enable_sql_instance_cpu_alert" {
  type        = bool
  default     = false
  description = "Enable the sql_instance_cpu_percent metric alert (non-serverless SKUs only)."
}

variable "sql_instance_cpu_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the SQL instance CPU alert. Defaults to alrt-sqlcpu-<resource-name>."
}

variable "sql_instance_cpu_alert_threshold" {
  type        = number
  default     = 70
  description = "SQL instance CPU percent threshold. Alert fires when above this value."
}

variable "sql_instance_cpu_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the SQL instance CPU alert. Auto-generated if not provided."
}

variable "sql_instance_cpu_alert_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4). Default is 3."
}

variable "sql_instance_cpu_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the SQL instance CPU alert is enabled."
}

variable "sql_instance_cpu_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the SQL instance CPU alert should auto mitigate when conditions clear."
}

variable "sql_instance_cpu_alert_frequency" {
  type        = string
  default     = "PT5M"
  description = "Evaluation frequency for the SQL instance CPU alert. Default PT5M."
}

variable "sql_instance_cpu_alert_window_size" {
  type        = string
  default     = "PT15M"
  description = "Time window for the SQL instance CPU alert. Default PT15M."
}

variable "sql_instance_cpu_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the SQL instance CPU alert criteria."
}

variable "sql_instance_cpu_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the SQL instance CPU alert criteria."
}

variable "sql_instance_cpu_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the SQL instance CPU alert."
}

########################################
# Alerts - SQL Instance Memory (Non-Serverless Only)
########################################

variable "enable_sql_instance_memory_alert" {
  type        = bool
  default     = false
  description = "Enable the sql_instance_memory_percent metric alert (non-serverless SKUs only)."
}

variable "sql_instance_memory_alert_name" {
  type        = string
  default     = null
  description = "Optional custom name for the SQL instance memory alert. Defaults to alrt-sqlmem-<resource-name>."
}

variable "sql_instance_memory_alert_threshold" {
  type        = number
  default     = 90
  description = "SQL instance memory percent threshold. Alert fires when above this value."
}

variable "sql_instance_memory_alert_description" {
  type        = string
  default     = null
  description = "Optional description for the SQL instance memory alert. Auto-generated if not provided."
}

variable "sql_instance_memory_alert_severity" {
  type        = number
  default     = 3
  description = "Alert severity (0-4). Default is 3."
}

variable "sql_instance_memory_alert_enabled" {
  type        = bool
  default     = true
  description = "Whether the SQL instance memory alert is enabled."
}

variable "sql_instance_memory_alert_auto_mitigate" {
  type        = bool
  default     = true
  description = "Whether the SQL instance memory alert should auto mitigate when conditions clear."
}

variable "sql_instance_memory_alert_frequency" {
  type        = string
  default     = "PT5M"
  description = "Evaluation frequency for the SQL instance memory alert. Default PT5M."
}

variable "sql_instance_memory_alert_window_size" {
  type        = string
  default     = "PT5M"
  description = "Time window for the SQL instance memory alert. Default PT5M."
}

variable "sql_instance_memory_alert_operator" {
  type        = string
  default     = "GreaterThan"
  description = "Operator for the SQL instance memory alert criteria."
}

variable "sql_instance_memory_alert_aggregation" {
  type        = string
  default     = "Average"
  description = "Aggregation for the SQL instance memory alert criteria."
}

variable "sql_instance_memory_alert_action_group_ids" {
  type        = list(string)
  default     = []
  description = "Action Group IDs to notify for the SQL instance memory alert."
}


