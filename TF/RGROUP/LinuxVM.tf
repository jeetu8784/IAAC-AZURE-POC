provider "azurerm" { }

# Create a Resource Group for the new Virtual Machine.
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

data "azurerm_resource_group" "main" {
  name = "${azurerm_resource_group.main.name}"
}

output "ResourceGroup-ID" {
  value = "${data.azurerm_resource_group.main.id}"
}
