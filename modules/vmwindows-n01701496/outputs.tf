# AVS Name
output "windows_availability_set_name" {
  value = azurerm_availability_set.windows_avs.name
}

output "vm_names" {
  value = [azurerm_windows_virtual_machine.windows_vm[*].name]
}

output "vm_ids" {
  value = [for vm in azurerm_windows_virtual_machine.windows_vm : vm.id]  # Extract VM IDs for Windows VMs
}

output "public_ip_addresses" {
  value = [azurerm_public_ip.windows_pip[*].ip_address]
}

output "private_ip_addresses" {
  value = [azurerm_network_interface.windows_nic[*].ip_configuration[*].private_ip_address]
}

output "dns_labels" {
  value = [azurerm_public_ip.windows_pip[*].domain_name_label]
}
