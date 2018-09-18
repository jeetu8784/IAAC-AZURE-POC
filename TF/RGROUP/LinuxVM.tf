provider "azurerm" { }

# Create a Resource Group for the new Virtual Machine.
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}
output "ResourceGroup-ID" {
  value = "${data.azurerm_resource_group_name.main.id}"
}
