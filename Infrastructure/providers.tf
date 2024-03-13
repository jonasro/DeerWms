terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.95.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.12.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6"
    }
  }

  required_version = ">= 1.7.3"

  # Backend
  backend "azurerm" {
    resource_group_name  = "rg-terraform-gh-actions"
    storage_account_name = "deerwmsterraformstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}