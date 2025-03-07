output "resource_group_name" {
  description = "The name of the created resource group"
  value       = module.rgroup.n01701496_rg_name
}

output "vnet_name" {
  description = "Virtual Network Name"
  value       = module.network.vnet_name
}

output "subnet_name" {
  description = "Subnet Name"
  value       = module.network.subnet_name
}

output "log_analytics_workspace_name" {
  value = module.common-n01701496.log_analytics_workspace_name
}

output "recovery_services_vault_name" {
  value = module.common-n01701496.recovery_services_vault_name
}

output "storage_account_name" {
  value = module.common-n01701496.storage_account_name
}

output "vm_details" {
  description = "Details of the deployed Linux VMs"
  value = module.vmlinux-n01701496.vm_details
}

output "storage_account_uri" {
  value = module.common-n01701496.storage_account_uri
}

output "windows_vm_hostname" {
  value = module.vmwindows-n01701496.vm_names
}

output "windows_vm_domain_name" {
  value = module.vmwindows-n01701496.dns_labels
}

output "windows_vm_private_ip" {
  value = module.vmwindows-n01701496.private_ip_addresses
}

output "windows_vm_public_ip" {
  value = module.vmwindows-n01701496.public_ip_addresses
}

output "loadbalancer_details" {
  description = "Details of the deployed load balancer"
  value = {
    loadbalancer_name      = module.loadbalancer-n01701496.loadbalancer_name
    loadbalancer_public_ip     = module.loadbalancer-n01701496.loadbalancer_public_ip
  }
}

output "datadisk_details" {
  description = "Details of the attached data disk"
  value = {
    disk_name          = module.datadisk-n01701496.data_disk_name
    disk_id            = module.datadisk-n01701496.data_disk_ids
  }
}

output "database_instance_name" {
  value = module.database-n01701496.db_instance_name
}
