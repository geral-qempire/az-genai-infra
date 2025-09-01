variable "name" {
  description = "(Optional) Name of the metric alert. If not provided, defaults to alrt-tok-<resource-name>."
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
For Processed Inference Tokens, pass one or more Azure AI Services (Cognitive Services) account resource IDs (Microsoft.CognitiveServices/accounts).
DESC
  type = list(string)

  validation {
    condition     = length(var.scopes) >= 1
    error_message = "Provide at least one scope (Cognitive Services account resource ID)."
  }
}

variable "threshold" {
  description = <<DESC
(Optional) Token threshold for Processed Inference Tokens (total over window).
Alert fires when the total over the window is greater than this value.
DESC
  type    = number
  default = 10000000

  validation {
    condition     = var.threshold >= 0
    error_message = "threshold must be greater than or equal to 0 tokens."
  }
}

variable "model_deployment_names" {
  description = <<DESC
(Optional) List of model deployment names to split the alert on using the ModelDeploymentName dimension.
Defaults to ["*"] to include all current and future deployments.
DESC
  type    = list(string)
  default = ["*"]
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

variable "auto_mitigate" {
  description = "(Optional) Whether the alert should auto mitigate when conditions clear."
  type        = bool
  default     = true
}

variable "metric_name" {
  description = "(Advanced) Metric name for processed tokens. Defaults to 'TokenTransaction'."
  type        = string
  default     = "TokenTransaction"
}

variable "tags" {
  description = "(Optional) Tags to apply to the metric alert resource."
  type        = map(string)
  default     = {}
}


