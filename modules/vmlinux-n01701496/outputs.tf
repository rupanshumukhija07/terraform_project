output "vm_details" {
  description = "Details of the deployed Linux VMs"
  value = {
    for key, vm in azurerm_linux_virtual_machine.linux_vm :
    key => {
      hostname      = vm.name
      private_ip    = azurerm_network_interface.linux_nic[key].private_ip_address
      public_ip     = azurerm_public_ip.linux_pip[key].ip_address
      domain_name   = azurerm_public_ip.linux_pip[key].domain_name_label
      nic_id        = azurerm_network_interface.linux_nic[key].id
      vm_id         = vm.id
    }
  }
}

