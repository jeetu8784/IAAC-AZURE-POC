provider "azurerm" { }

data "azurerm_resource_group" "main" {
  name                      = "${var.networkSecurityGroupName}"
  }
data "azurerm_network_security_group" "main" {
  name                      = "${var.networkSecurityGroupName}"
  }
data "azurerm_subnet" "main" {
  name                      = "${var.subnetName}"
  }
data "azurerm_public_ip" "main" {
  name                      = "${var.networkSecurityGroupName}"
  }
# Create a network interface for VMs and attach the PIP and the NSG
resource "azurerm_network_interface" "main" {
  name                      = "${var.networkInterfaceName}"
  location                  = "${var.location}"
  resource_group_name       = "${data.azurerm_resource_group.main.id}"
  network_security_group_id = "${data.azurerm_network_security_group.main.id}"

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = "${data.azurerm_subnet.main.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${data.azurerm_public_ip.main.id}"
  }
}
output "NIC-ID" {
  value = "${azurerm_network_interface.main.id}"
}
