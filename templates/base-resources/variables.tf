variable "infra_subscription_id" {
  description = "Subscription ID where resources are deployed."
  type        = string
}

variable "dns_subscription_id" {
  description = "Subscription ID that holds Private DNS zones."
  type        = string
}

variable "environment" {
  description = "Environment project (dev, qua or prd)"
  type        = string
}

variable "service_prefix" {
  description = "Prefix or name of the project"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources."
  type        = string
}

variable "dns_resource_group_name" {
  description = "Resource Group name containing required Private DNS Zones."
  type        = string
}

variable "vnet_resource_group_name" {
  description = "Resource Group name where the existing Virtual Network resides."
  type        = string
}

variable "vnet_name" {
  description = "Name of the existing Virtual Network."
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing Subnet to use for Private Endpoints."
  type        = string
}

variable "tags" {
  description = "Optional tags to add to resources."
  type        = map(string)
  default     = {}
}


variable "log_analytics_workspace_name" {
  description = "Name of an existing Log Analytics Workspace to link to Application Insights."
  type        = string
}

variable "log_analytics_workspace_resource_group_name" {
  description = "Resource Group name where the existing Log Analytics Workspace resides."
  type        = string
}


