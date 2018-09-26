terraform {
  backend "azurerm" {
  resource_group_name = "AZURE-POC-TF"
  storage_account_name = "tfazurestorageaccount"
  container_name = "terraformstate"
  key="vm.terraform.tfstate"
  }
}
