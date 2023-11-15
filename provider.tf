
provider "azurerm" {
  subscription_id = var.subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "cliff" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_availability_set" "cliff-aset" {
  name                = "cliff-aset"
  location            = azurerm_resource_group.cliff.location
  resource_group_name = azurerm_resource_group.cliff.name
}