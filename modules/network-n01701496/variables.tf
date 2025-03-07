variable "vnet_name" {}
variable "location" {}
variable "vnet_space" {}
variable "subnet_name" {}
variable "subnet_address_space" {}
variable "nsg_name" {}
variable "n01701496_rg_name" {}
variable "n01701496_rg" {}
variable "tags" {
  type = map(string)
  description = "Common tags for all resources"
}

