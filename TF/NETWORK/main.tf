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

# Create a Network Security Group with some rules
resource "azurerm_network_security_group" "tfpocnsg" {
  name                = "${var.networkSecurityGroupName}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

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
output "TFPOCNSG-ID" {
  value = "${azurerm_network_security_group.tfpocnsg.id}"
}

# Create a network interface for VMs and attach the PIP and the NSG
resource "azurerm_network_interface" "main" {
  name                      = "${var.networkInterfaceNameNew}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group}"
  network_security_group_id = "${azurerm_network_security_group.tfpocnsg.id}"
  
  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "dynamic"
  }
}

output "NIC-ID" {
  value = "${azurerm_network_interface.main.id}"
}
