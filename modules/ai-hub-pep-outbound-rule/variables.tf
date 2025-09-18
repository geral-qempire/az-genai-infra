variable "name" {
  type        = string
  default     = null
  description = "Optional custom name; defaults to pep-<resource_name> when omitted."
}

variable "parent_id" {
  type        = string
  description = "The parent resource ID (Azure AI Hub) under which to create the outbound rule."
}

variable "service_resource_id" {
  type        = string
  description = "The resource ID of the destination service for the Private Endpoint."
}

variable "sub_resource_target" {
  type        = string
  description = "The subresource target of the destination service (e.g. blob, vault, account, searchService, sqlServer)."
}

variable "spark_enabled" {
  type        = bool
  description = "Whether Spark should use this Private Endpoint."
  default     = false
}


