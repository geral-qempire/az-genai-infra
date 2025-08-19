variable "ai_project_id" {
  type        = string
  description = "The ID of the target Azure AI Project (workspace) under which to create the connection."
}

variable "ai_services_module" {
  # Allows passing module.ai_services directly
  type = object({
    ai_services_id          = string
    ai_services_name        = string
    ai_services_primary_key = string
  })
  default     = null
  description = "Pass module.ai_services directly (outputs from modules/ai-services/resource)."
}


