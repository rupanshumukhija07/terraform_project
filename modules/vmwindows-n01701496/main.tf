resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.n01701496_rg_name
  managed                      = true
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_network_interface" "windows_nic" {
  count               = var.vm_count
  name                = "n01701496-w-vm-nic${count.index + 1}"
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  ip_configuration {
    name                          = "internal-ip-${format("%d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.windows_pip[*].id, count.index + 1)
  }
  tags = var.tags
}

resource "azurerm_public_ip" "windows_pip" {
  count               = var.vm_count
  name                = "n01701496-w-vm-pip-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  allocation_method   = "Static"
  sku = "Basic"

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = var.vm_count
  name                = "n01701496-c-vm${count.index + 1}"
  resource_group_name = var.n01701496_rg_name
  location            = var.location
  availability_set_id = azurerm_availability_set.windows_avs.id
  size                = var.vm_size
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  network_interface_ids = [
    azurerm_network_interface.windows_nic[count.index].id
  ]
  os_disk {
    name                 = "osdisk-${count.index + 1}"
    caching              = var.windows_os_disk.caching
    storage_account_type = var.windows_os_disk.storage_account_type
    disk_size_gb         = var.windows_os_disk.disk_size
  }
  source_image_reference {
    publisher = var.windows_os_info.publisher
    offer     = var.windows_os_info.offer
    sku       = var.windows_os_info.sku
    version   = var.windows_os_info.version
  }
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                   = var.vm_count
  virtual_machine_id      = azurerm_windows_virtual_machine.windows_vm[count.index].id
  name                    = "IaaSAntimalwar"
  publisher               = "Microsoft.Azure.Security"
  type                    = "IaaSAntimalware"
  type_handler_version    = "1.3"
  auto_upgrade_minor_version = true
  settings                = <<SETTINGS
    {
      "AntimalwareEnabled": true,
      "RealtimeProtectionEnabled": true,
      "ScheduledScanSettings": {
        "isEnabled": true,
        "day": 1,
        "time": 120,
        "scanType": "Quick"
      },
      "Exclusions": {
        "Extensions": ".log;.tmp",
        "Paths": "C:\\Temp;C:\\Logs",
        "Processes": "notepad.exe;calc.exe"
      }
    }
  SETTINGS

  depends_on = [
    azurerm_windows_virtual_machine.windows_vm
  ]
}
