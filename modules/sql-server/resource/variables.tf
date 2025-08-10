variable "environment" {
  type        = string
  description = "Environment project (dev, qua or prd)"
}

variable "service_prefix" {
  type        = string
  description = "Prefix or name of the project"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the SQL Server should exist."
}

variable "region_abbreviations" {
  type        = map(string)
  description = "Map of Azure locations to abbreviations. Recommended to pass from the shared modules/region-abbreviations module."
}

### Naming

variable "serial_number" {
  type        = string
  description = "Required serial number suffix for the server name (used in azpds<env-initial><serial>)."
}

### Server Admin (SQL authentication)

variable "administrator_login" {
  type        = string
  description = "The Administrator Login for the SQL Server."
}

variable "administrator_login_password" {
  type        = string
  sensitive   = true
  description = "The Password associated with the administrator_login for the SQL Server."
}

### Microsoft Entra (Azure AD) Administrator

variable "entra_admin_login_name" {
  type        = string
  default     = ""
  description = "The login name (UPN or display name) of the Microsoft Entra administrator."
}

 

variable "entra_admin_object_id" {
  type        = string
  default     = ""
  description = "The Object ID of the Microsoft Entra administrator (User, Group, or Service Principal)."
}

variable "entra_admin_tenant_id" {
  type        = string
  default     = ""
  description = "Optional Tenant ID for the Entra admin. If empty, current tenant will be used."
}

### Optional Settings

variable "server_version" {
  type        = string
  default     = "12.0"
  description = "The version for the SQL Server."
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "The Minimum TLS Version for all connections."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Public Network Access is allowed for this resource."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = {
    type = "SystemAssigned"
  }
  description = "Managed identity configuration. Possible types: SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned."
  }
}

### Private Endpoint

variable "enable_private_endpoint" {
  type        = bool
  default     = true
  description = "Create a private endpoint to the SQL Server."
}

variable "dns_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group name containing the Private DNS zone for SQL Server (privatelink.database.windows.net)."
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "Subnet ID for the private endpoint."
}

variable "private_endpoint_location" {
  type        = string
  default     = ""
  description = "Location to deploy the Private Endpoint. If empty, falls back to module location."
}

### Tags

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to add to resources."
}


