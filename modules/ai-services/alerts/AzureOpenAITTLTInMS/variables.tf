variable "name" {
  description = "(Optional) Name of the metric alert. If not provided, defaults to alrt-ttlt-<resource-name>."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "(Required) Resource group in which to create the alert."
  type        = string
}

variable "scopes" {
  description = <<DESC
(Required) List of resource IDs that the alert monitors.
For AzureOpenAITTLTInMS, pass one or more Azure AI Services (Cognitive Services) account resource IDs (Microsoft.CognitiveServices/accounts).
DESC
  type = list(string)

  validation {
    condition     = length(var.scopes) >= 1
    error_message = "Provide at least one scope (Cognitive Services account resource ID)."
  }
}

variable "threshold" {
  description = <<DESC
(Optional) Time To Last Token threshold in milliseconds.
Alert fires when the metric average over the window is greater than this value.
DESC
  type    = number
  default = 5

  validation {
    condition     = var.threshold > 0
    error_message = "threshold must be greater than 0 milliseconds."
  }
}

variable "model_deployment_names" {
  description = <<DESC
(Required) List of model deployment names to split the alert on using the ModelDeploymentName dimension.
Pass one or more deployment names that exist under the Azure OpenAI resource.
DESC
  type = list(string)
}

variable "description" {
  description = "(Optional) Description for the alert."
  type        = string
  default     = null
}

variable "enabled" {
  description = "(Optional) Whether the alert is enabled."
  type        = bool
  default     = true
}

variable "action_group_ids" {
  description = "(Optional) Action Group IDs to notify when the alert fires."
  type        = list(string)
  default     = []
}


