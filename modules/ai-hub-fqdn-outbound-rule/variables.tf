variable "name" {
  type        = string
  description = "The name of the outbound rule to create."
}

variable "parent_id" {
  type        = string
  description = "The parent resource ID (Azure AI Hub) under which to create the outbound rule."
}

variable "fqdn" {
  type        = string
  description = "The Fully Qualified Domain Name to allow as an outbound rule."
}

variable "spark_enabled" {
  type        = bool
  description = "Whether Spark should use this outbound rule (if applicable)."
  default     = false
}


