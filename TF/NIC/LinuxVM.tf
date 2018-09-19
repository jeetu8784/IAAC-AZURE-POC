provider "azurerm" { }

# Create a network interface for VMs and attach the PIP and the NSG
resource "azurerm_network_interface" "main" {
  name                      = "${var.networkInterfaceNameNew}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group}"
  
  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = "${var.defaultsubnetid}"
    private_ip_address_allocation = "dynamic"
  }
}
output "NIC-ID" {
  value = "${azurerm_network_interface.main.id}"
}
