
resource "azurerm_lb" "lb" {
  name                = "nobsloadbalancer"
  location            = azurerm_resource_group.cliff.location
  resource_group_name = azurerm_resource_group.cliff.name

  frontend_ip_configuration {
    name                 = "lb_frontend"
    public_ip_address_id = azurerm_public_ip.lbip.id
  }
}

resource "azurerm_lb_backend_address_pool" "b_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool1"
}

