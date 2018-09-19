provider "azurerm" { }
# Create a network interface for VMs and attach the PIP and the NSG
resource "azurerm_network_interface" "main" {
  name                      = "${var.networkInterfaceName}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group}"
  network_security_group_id = "${var.networkSecurityGroupName}"

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = "${var.subnetName}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${var.publicIpAddressName}"
  }
}

output "NIC-ID" {
  value = "${azurerm_network_interface.main.id}"
}
