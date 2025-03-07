variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "n01701496_rg_name" {
  description = "Resource group name"
  type        = string
}

variable "vm_network_interface_ids" {
  description = "Map of network interface IDs for VMs to be associated with the load balancer backend"
  type        = map(string)
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
}