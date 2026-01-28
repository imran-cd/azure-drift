terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "78d905a9-f821-4498-97c0-b9bdb37457c1"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-min-aci"
  location = "West Europe"
}

resource "azurerm_container_group" "cg" {
  name                = "aci-min"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = "aci-min-${random_string.suffix.result}"

  container {
    name   = "nginx"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = 0.5
    memory = 1.0

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

output "aci_url" {
  value = "http://${azurerm_container_group.cg.fqdn}"
}
