terraform {
  backend "azurerm" {
    resource_group_name   = "__rgName__"
    storage_account_name  = "__strName__"
    container_name        = "__tfContainerName__"
    key                   = "__tfKey__"
  }
}

provider "azurerm" {
  version = "=2.40.0"
  features {   
  }
}