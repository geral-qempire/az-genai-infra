variable "workspace_id" {
  description = "The ID of the Azure Machine Learning workspace (Hub) where outbound rules will be created."
  type        = string
}

variable "outbound_rules" {
  description = "Map of outbound rules keyed by sequential name (e.g., rule0001). Each object defines either an FQDN or a private-endpoint rule."
  type = map(object({
    type                = string                 # "FQDN" | "private-endpoint"
    destination         = optional(string)       # for FQDN
    service_resource_id = optional(string)       # for private-endpoint
    sub_resource_target = optional(string)       # for private-endpoint
  }))


  validation {
    condition     = alltrue([for r in values(var.outbound_rules) : contains(["fqdn", "private-endpoint"], lower(r.type))])
    error_message = "Each rule.type must be either 'FQDN' or 'private-endpoint'."
  }

  validation {
    condition = alltrue([
      for r in values(var.outbound_rules) : (
        lower(r.type) == "fqdn" ? try(length(r.destination) > 0, false) : true
      )
    ])
    error_message = "FQDN rules must set a non-empty destination."
  }

  validation {
    condition = alltrue([
      for r in values(var.outbound_rules) : (
        lower(r.type) == "private-endpoint" ? (
          try(length(r.service_resource_id) > 0, false) && try(length(r.sub_resource_target) > 0, false)
        ) : true
      )
    ])
    error_message = "private-endpoint rules must set both service_resource_id and sub_resource_target."
  }
}


