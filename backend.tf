terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstateimran123456"
    container_name       = "tfstate"
    key                  = "australiacentral/vm/terraform.tfstate"
  }
}
