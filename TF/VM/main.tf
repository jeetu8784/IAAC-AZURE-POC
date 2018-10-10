provider "azurerm" {
subscription_id = " 10bd7109-7882-47f8-b6e6-a8c123c66305”
tenant_id       = "189de737-c93a-4f5a-8b68-6f4ca9941912"
}


data "azurerm_network_interface" "main" {
  name                      = "${var.networkInterfaceName}"
  resource_group_name       = "${var.resource_group}"
  }

data "azurerm_image" "os" {
  name			    = "${var.OsImageName}"
  resource_group_name	    = "${var.resource_group}"
  }

# Create a new Virtual Machine based on the Golden Image
resource "azurerm_virtual_machine" "vm" {
  name                             = "${var.virtualMachineName}"
  location                         = "${data.azurerm_network_interface.main.location}"
  resource_group_name              = "${data.azurerm_network_interface.main.resource_group_name}"
  network_interface_ids            = ["${data.azurerm_network_interface.main.id}"]
  vm_size                          = "${var.virtualMachineSize}"
  delete_os_disk_on_termination    = true

  storage_image_reference {
  id				   = "${data.azurerm_image.os.id}"
  }

  storage_os_disk {
    name              = "${var.virtualMachineName}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.virtualMachineName}"
    admin_username = "${var.adminUsername}"
    admin_password = "${var.adminPassword}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
data "azurerm_public_ip" "main" {
   name                = "${var.publicIpAddressName}"
  resource_group_name = "${azurerm_virtual_machine.vm.resource_group_name}"
  }
output "PublicIP" {
  value = "${data.azurerm_public_ip.main.ip_address}"
  }
