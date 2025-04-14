resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  location                     = var.location
  resource_group_name          = var.n01701496_rg_name
  managed                      = true
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_public_ip" "linux_pip" {

  for_each            = var.linux_name
  name                = "${var.linux_name[each.key]}-pip-${each.key}"
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = "${each.key}"
  tags                = var.tags
}


resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.linux_name
  name                = "${var.linux_name[each.key]}-nic-${each.key}"
  location            = var.location
  resource_group_name = var.n01701496_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }
  tags = var.tags

}


resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.linux_name
  name                = "${var.linux_name[each.key]}-${each.key}"
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  availability_set_id = azurerm_availability_set.linux_avs.id
  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id
  ]
  size = var.vm_size

  os_disk {
    name                 = "${var.linux_name[each.key]}-os-disk-${each.key}"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size
  }

  source_image_reference {
    publisher = var.linux_os_info.publisher
    offer     = var.linux_os_info.offer
    sku       = var.linux_os_info.sku
    version   = var.linux_os_info.version
  }

  admin_username = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
  
  tags = var.tags
}


# VM Extensions
resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each            = var.linux_name
  name                = "network-watcher-${each.key}"
  virtual_machine_id  = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher           = "Microsoft.Azure.NetworkWatcher"
  type                = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each            = var.linux_name
  name                = "azure-monitor-${each.key}"
  virtual_machine_id  = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.9"
}

resource "null_resource" "ansible_provision" {
  provisioner "local-exec" {
    command = <<EOT
      ANSIBLE_HOST_KEY_CHECKING=False \
      ansible-playbook -i automation/inventory automation/playbook-n01701496.yaml
    EOT
  }

  depends_on = [
    azurerm_linux_virtual_machine.linux_vm
  ]
}
