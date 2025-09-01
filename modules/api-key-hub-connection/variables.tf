variable "parent_id" {
  type        = string
  description = "The parent resource ID (Azure AI Project/workspace) under which to create the connection."
}

variable "connection_name" {
  type        = string
  description = "Name for the connection resource under the AI Project (e.g., con_custom_api)."
}

variable "target_url" {
  type        = string
  description = "The target endpoint URL this connection points to."
}

variable "api_key" {
  type        = string
  sensitive   = true
  description = "API key to store in the connection credentials."
}

variable "metadata" {
  type        = map(string)
  default     = {}
  description = "Optional metadata key/values to store with the connection."
}


