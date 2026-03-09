variable "service_prefix" {
  type        = string
  description = "Prefix used in resource naming (e.g. 'genai')."
}

variable "location" {
  type        = string
  description = "Azure region for all networking resources."
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "Address space for the virtual network."
}

variable "subnet_address_prefixes" {
  type        = map(string)
  description = "Address prefix for each environment subnet. Must contain keys: dev, qua, prd."
  default = {
    dev = "10.0.1.0/24"
    qua = "10.0.2.0/24"
    prd = "10.0.3.0/24"
  }

  validation {
    condition     = alltrue([for env in ["dev", "qua", "prd"] : contains(keys(var.subnet_address_prefixes), env)])
    error_message = "subnet_address_prefixes must contain keys: dev, qua, prd."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to apply to all resources."
}
