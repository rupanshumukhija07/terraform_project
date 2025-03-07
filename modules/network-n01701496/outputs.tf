output "vnet_name" {
  value = azurerm_virtual_network.n01701496-vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.n01701496-subnet.name
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.n01701496-subnet.id
}