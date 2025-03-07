variable "vm_ids" {
  description = "List of VM IDs to attach the disks to"
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "n01701496_rg_name" {}

variable "tags" {
  description = "Tags to apply to the resources."
  type        = map(string)

}
