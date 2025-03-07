variable "linux_avs" {
  description = "The availability set for Linux VMs"
  type        = string
}

variable "n01701496_rg_name" {}

variable "location" {}

variable "subnet_id" {
  description = "The ID of the subnet to be used for network interfaces."
  type        = string
}

variable "nb_count" {
  description = "Number of VMs to deploy"
  type        = number
}

variable "linux_name" {
  description = "The base name for the Linux VM"
  type = map(string)
}


variable "admin_username" {
  description = "Admin username for the Linux VM."
  default     = "n01701496"
}

variable "public_key_path" {
  description = "Path to the public SSH key."
  default     = "/home/n01701496/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to the public SSH key."
  default     = "/home/n01701496/.ssh/id_rsa"
}

variable "os_disk" {
  description = "Attributes for the OS disk."
  default = {
    storage_account_type = "Premium_LRS"
    disk_size            = 32
    caching              = "ReadWrite"
  }
}

variable "linux_os_info" {
  description = "Ubuntu Linux OS information."
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-DAILY-LTS"
    version   = "latest"
  }
}

variable "storage_account_uri" {
  description = "URI of the storage account for boot diagnostics"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine."
}
variable "tags" {
  type = map(string)
  description = "Common tags for all resources"
}