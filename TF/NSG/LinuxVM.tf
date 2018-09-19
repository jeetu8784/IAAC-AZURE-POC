provider "azurerm" { }
# Create a Network Security Group with some rules
resource "azurerm_network_security_group" "sshnsg" {
  name                = "${var.networkSecurityGroupName}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group.name}"
  security_rule {
    name                       = "allow_SSH"
    description                = "Allow SSH access"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "httpnsg" {
  name                = "${var.httpnetworkSecurityGroupName}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group.name}"
  security_rule {
    name                       = "allow_HTTP"
    description                = "Allow HTTP access"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
output "HTTPNSG-ID" {
  value = "${azurerm_network_security_group.httpnsg.id}"
}
output "SSHNSG-ID" {
  value = "${azurerm_network_security_group.sshnsg.id}"
}
