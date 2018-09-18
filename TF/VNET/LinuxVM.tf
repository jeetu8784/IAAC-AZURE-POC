provider "azurerm" { }

# Create a Virtual Network within the Resource Group
resource "azurerm_virtual_network" "main" {
  name                = "${var.virtualNetworkName}"
  address_space       = ["${var.addressPrefix}"]
  resource_group_name = "${var.resource_group}"
  location            = "${var.location}"
}

# Create a Subnet within the Virtual Network
resource "azurerm_subnet" "internal" {
  name                 = "${var.subnetName}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  resource_group_name  = "${azurerm_virtual_network.main.resource_group_name}"
  address_prefix       = "${var.subnetPrefix}"
}

output "SubNet-ID" {
  value = "${azurerm_subnet.internal.id}"
}
