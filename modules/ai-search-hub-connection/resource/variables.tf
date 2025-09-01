variable "parent_id" {
  type        = string
  description = "The parent resource ID (Azure AI Project/workspace) under which to create the connection."
}

variable "ai_search_service_module" {
  # Allows passing module.ai_search_service directly
  type = object({
    search_service_id   = string
    search_service_name = string
    search_service_primary_key = string
  })
  description = "Pass module.ai_search_service directly (outputs from modules/ai-search-service/resource)."
}


