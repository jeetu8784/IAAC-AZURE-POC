provider "azurerm" { }

# Create a Public IP for the Virtual Machine
resource "azurerm_public_ip" "main" {
  name                         = "${var.publicIpAddressNameNew}"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group}"
  public_ip_address_allocation = "${var.publicIpAddressType}"
}
data "azurerm_network_interface" "main" {
  resource_group_name = "${var.resource_group}"
}

output "example" {
  value = "${data.azurerm_network_interface.main.ids}"
}
output "AzurePublicIP" {
  value = "${azurerm_public_ip.main.ip_address}"
}
