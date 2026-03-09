variable "service_prefix" {
  type        = string
  description = "Prefix or name used in the resource group name."
}

variable "location" {
  type        = string
  description = "Azure region for the resource group."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to apply to the resource group and DNS zones."
}
