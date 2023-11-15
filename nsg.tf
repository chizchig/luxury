resource "azurerm_network_security_group" "camper-nsg" {
  name                = "nsg"
  location            = azurerm_resource_group.cliff.location
  resource_group_name = azurerm_resource_group.cliff.name

  security_rule {
    name                       = "allowWinRm"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["5986"] # Winrm over HTTPS
    source_address_prefix      = var.cloud_shell_source
    destination_address_prefix = "*" # Allow traffic to any destination
  }

  security_rule {
    name                       = "allowWinRm2"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["5986"] # Winrm over HTTPS
    source_address_prefix      = var.cloud_shell_source
    destination_address_prefix = "*" # Allow traffic to any destination
  }

  security_rule {
    name                       = "allowWinRm3"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["5986"] # Winrm over HTTPS
    source_address_prefix      = var.cloud_shell_source
    destination_address_prefix = "*" # Allow traffic to any destination
  }
}


resource "azurerm_public_ip" "vmIps" {
  count               = 2
  name                = "publicVmIp-${count.index}"
  location            = azurerm_resource_group.cliff.location
  resource_group_name = azurerm_resource_group.cliff.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.domain_name_prefix}-${count.index}"
}

resource "azurerm_network_interface" "mars" {
  count               = 2
  name                = "camper_nic-${count.index}"
  location            = azurerm_resource_group.cliff.location
  resource_group_name = azurerm_resource_group.cliff.name
  ip_configuration {
    name                          = "ip_config"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vmIps[count.index].id
  }
  depends_on = [azurerm_subnet.internal]
}


resource "azurerm_network_interface_security_group_association" "nsg" {
  count                     = 2
  network_interface_id      = azurerm_network_interface.mars[count.index].id
  network_security_group_id = azurerm_network_security_group.camper-nsg.id
}