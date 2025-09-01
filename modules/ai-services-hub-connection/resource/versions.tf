terraform {
  required_version = ">= 1.12.1, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.38"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}


