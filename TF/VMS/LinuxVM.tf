provider "azurerm" { }

data "azurerm_network_interface" "main" {
  name                      = "${var.networkInterfaceName}"
  resource_group_name       = "${var.resource_group}"
  }

# Create a Public IP for the Virtual Machine
resource "azurerm_public_ip" "main" {
  name                         = "${var.publicIpAddressName}"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group}"
  public_ip_address_allocation = "${var.publicIpAddressType}"
}

# Create a new Virtual Machine based on the Golden Image
resource "azurerm_virtual_machine" "vm" {
  name                             = "${var.virtualMachineName}"
  location                         = "${azurerm_public_ip.main.location}"
  resource_group_name              = "${azurerm_public_ip.main.resource_group_name}"
  network_interface_ids            = ["${data.azurerm_network_interface.main.id}"]
  vm_size                          = "${var.virtualMachineSize}"
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.virtualMachineName}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = "40"
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

data "azurerm_public_ip" "newIp" {
  name                = "${azurerm_public_ip.main.name}"
  resource_group_name = "${azurerm_virtual_machine.vm.resource_group_name}"
}

output "PublicIP" {
  value = "${data.azurerm_public_ip.newIp.name}"
}
