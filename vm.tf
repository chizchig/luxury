# Virtual MACHINE

resource "azurerm_windows_virtual_machine" "campervms" {
  count                 = 2
  name                  = "campervms-${count.index + 1}"
  resource_group_name   = azurerm_resource_group.cliff.name
  location              = var.location
  size                  = "Standard_B1s"
  admin_username        = "cadmin"
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.mars[count.index].id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

}

# resource "azurerm_virtual_machine_extension" "enablewinrm" {
#   count              = 2
#   name               = "enablewinrm-${count.index}"
#   virtual_machine_id = azurerm_windows_virtual_machine.campervms[count.index].id
#   publisher          = "Microsoft.Compute"
#   type               = "CustomScriptExtension"
#   type_handler_version = "1.9"

#   settings = <<SETTINGS
#   {
#     "fileUris":["https://raw.githubusercontent.com/exampleuser/scripts/master/custom_script.sh"],
#     "commandToExecute":"bash custom_script.sh"
#   }
#   SETTINGS
# }

