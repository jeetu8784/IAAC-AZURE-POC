provider "azurerm" { }


data "azurerm_network_interface" "main" {
  name                      = "${var.networkInterfaceName}"
  resource_group_name       = "${var.resource_group}"
  }

output "example" {
  value = "${data.azurerm_network_interface.main.id}"
}

# Create a Public IP for the Virtual Machine
resource "azurerm_public_ip" "main" {
  name                         = "${var.publicIpAddressName}"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group}"
  public_ip_address_allocation = "${var.publicIpAddressType}"
  
  tags{
    environment = "${data.azurerm_network_interface.main.id}"
    }
}

data "azurerm_public_ip" "newmain"{
  name = "${azurerm_public_ip.main.name}"
  resource_group_name          = "${var.resource_group}"
  }

output "AzurePublicIP" {
  value = "${data.azurerm_public_ip.newmain.ip_address}"
}
