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
}

provider "azurerm" {
  features {}
}