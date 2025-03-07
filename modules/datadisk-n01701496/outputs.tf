output "data_disk_name" {
  description = "The name of the data disks created."
  value       = azurerm_managed_disk.data_disk[*].name
}

output "data_disk_ids" {
  description = "The IDs of the data disks created."
  value       = azurerm_managed_disk.data_disk[*].id
}

output "data_disk_attachments" {
  description = "Details of the data disk attachments to the VMs."
  value       = azurerm_virtual_machine_data_disk_attachment.data_disk_attachment[*].id
}
