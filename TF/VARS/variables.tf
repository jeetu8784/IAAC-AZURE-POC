variable "resource_group" {
  description = "The name of the resource group in which to create the virtual network."
  default     = "AZURE-POC-TF"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "eastus"
}

variable "virtualMachineName" {
  description = "VM name referenced also in storage-related names."
  default     = "AZURE-POC-TF"
}

variable "virtualMachineSize" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_B1s"
}

variable "adminUsername" {
  description = "Administrator user name."
  default     = "azure-poc-admin"
}

variable "virtualNetworkName" {
  description = "The name for the virtual network."
  default     = "AZURE-POC-TF-vnet"
}

variable "networkInterfaceName" {
  description = "Name of network interface resource."
  default     = "azure-poc-tf-nic"
}

variable "networkSecurityGroupName" {
  description = "Name for the network security group resource."
  default     = "AZURE-POC-TF-nsg"
}

variable "adminPassword" {
  description = "Administrator password"
  default     = "Doyouknowme@1"
}

variable "addressPrefix" {
  description = "The address space that is used by the virtual network."
  default     = "12.0.0.0/24"
}

variable "subnetName" {
  description = "Subnet resource name."
  default     = "default"
}

variable "subnetPrefix" {
  description = "The address prefix to use for the subnet."
  default     = "12.0.0.0/24"
}

variable "publicIpAddressName" {
  description = "The name of public ip resource."
  default     = "AZURE-POC-TF-ip"
}

variable "publicIpAddressType" {
  default     = "Dynamic"
}
