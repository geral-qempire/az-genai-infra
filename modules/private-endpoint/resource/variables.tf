variable "name" {
  description = "(Required) Name of the Private Endpoint."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Resource group in which to create the Private Endpoint."
  type        = string
}

variable "location" {
  description = "(Required) Azure region (e.g., westeurope)."
  type        = string
}

variable "subnet_id" {
  description = "(Required) ID of the subnet where the Private Endpoint NIC will be created."
  type        = string
}

variable "private_connection_resource_id" {
  description = <<DESC
(Required) The ID of the target resource to connect to (e.g., Storage Account, Key Vault, etc.).
Example: /subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Storage/storageAccounts/<name>
DESC
  type = string
}

variable "subresource_names" {
  description = <<DESC
(Required) The subresource(s) to connect to on the target resource (service group). 
Examples: ["blob"], ["file"], ["vault"], ["sqlServer"], etc. Values depend on the target service.
DESC
  type = list(string)

  validation {
    condition     = length(var.subresource_names) > 0
    error_message = "Provide at least one subresource name."
  }
}

variable "private_dns_zone_ids" {
  description = <<DESC
(Required) List of Private DNS Zone IDs to link via a DNS Zone Group.
You must provide at least one zone ID (e.g., the privatelink zone for your subresource).
DESC
  type = list(string)

  validation {
    condition     = length(var.private_dns_zone_ids) > 0
    error_message = "private_dns_zone_ids must contain at least one Private DNS Zone ID."
  }
}

variable "is_manual_connection" {
  description = "(Optional) Whether the connection requires manual approval by the resource owner."
  type        = bool
  default     = false
}

variable "request_message" {
  description = "(Optional) A message for manual connections, shown to the approver."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) Tags to apply to the Private Endpoint."
  type        = map(string)
  default     = {}
}
