variable "windows_avs" {
  description = "Windows availabilitt set"
  type = string
}

variable "vm_count" {
  description = "Number of VMs to deploy"
  type        = number
}

variable "windows_admin_username" {
  description = "Admin username for the Windows VM."
  default     = "n01701496"
}

variable "windows_admin_password" {
  description = "Admin password for the Windows VM."
  default     = "Kripalusev@7"
}


variable "windows_os_disk" {
  description = "Attributes for the OS disk."
  default = {
    storage_account_type = "StandardSSD_LRS"
    disk_size            = 128
    caching              = "ReadWrite"
  }
}

variable "windows_os_info" {
  description = "Windows  OS information."
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}


variable "subnet_id" {
  description = "The ID of the subnet to be used for network interfaces."
  type        = string
} 
variable "location" {}
variable "windows" {} 
variable "n01701496_rg_name" {}
variable "vm_size" {
  description = "Size of the virtual machine."
}

variable "boot_diagnostics_storage_account_uri" {
  description = "The URI of the storage account for boot diagnostics."
  type        = string
}

variable "tags" {
  type = map(string)
  description = "Common tags for all resources"
}