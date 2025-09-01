variable "server_id" {
  type        = string
  description = "The ID of the parent Azure SQL Server."
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


