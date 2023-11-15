# Virtual  Network 

resource "azurerm_virtual_network" "vnet" {
  name                = "camper-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.cliff.location
  resource_group_name = azurerm_resource_group.cliff.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.cliff.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.2.0/24"]

  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_public_ip" "lbip" {
  name                = "publicLbIp"
  location            = azurerm_resource_group.cliff.location
  resource_group_name = azurerm_resource_group.cliff.name
  allocation_method   = "Static"
}