terraform {
  backend "azurerm" {
    resource_group_name  = "rg-swc-tfstate-nonprod"
    storage_account_name = "stswcqetfstatenonprod"
    container_name       = "genai-tfstate"
    key                  = "chatbot-framework-core-dev/terraform.tfstate"  # set in .tfbackend of each environment
  }
}