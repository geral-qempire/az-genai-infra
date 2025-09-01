variable "rbac" {
  description = "Map of RBAC bindings keyed by a stable id"
  type = map(object({
    principal_id         = string
    scope_id             = string
    role_definition_id   = optional(string)
    role_definition_name = optional(string)
    principal_type       = optional(string)
  }))
}


