terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01701496RG"
    storage_account_name = "tfstaten01701496sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}

