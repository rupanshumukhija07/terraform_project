resource "azurerm_managed_disk" "data_disk" {
  count                = length(var.vm_ids)  # Create 4 disks
  name                 = "datadisk-${count.index + 1}"
  location             = var.location
  resource_group_name = var.n01701496_rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10  # Size of each disk (10GB)

  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  count                = length(var.vm_ids)  # Attach to 4 VMs
  virtual_machine_id   = element(var.vm_ids, count.index)
  managed_disk_id      = azurerm_managed_disk.data_disk[count.index].id
  caching             = "ReadWrite"
  lun                  = count.index # Logical Unit Number (LUN) for the disk 

}
