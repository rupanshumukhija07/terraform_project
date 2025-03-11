module "rgroup" {
  source                = "./modules/rgroup-n01701496"
  n01701496_rg_name   = "n01701496-RG"
  location              = "East US"
  tags = local.common_tags
}

module "network" {
  source               = "./modules/network-n01701496"
  vnet_name            = "n01701496-vnet"
  n01701496_rg_name              = "n01701496-RG"
  vnet_space   = "10.0.0.0/16"
  subnet_name           = "n01701496-subnet"
  n01701496_rg              = "n01701496-RG"
  subnet_address_space = "10.0.1.0/24"
  location             = "East US"
  nsg_name             = "nsg"
  depends_on = [module.rgroup]
  tags = local.common_tags
}

module "common-n01701496" {
  source               = "./modules/common-n01701496"
  n01701496_rg_name    = "n01701496-RG"
  location             = "East US"
  storage_account      = "n01701496storageaccount"

  log_analytics_workspace = {
    law_name   = "n01701496-logworkspace"
    log_sku    = "PerGB2018"
    retention  = "30"
  }

  recovery_services_vault = {
    vault_name = "n01701496-recoveryvault"
    vault_sku  = "Standard"
   
  }

depends_on = [module.rgroup]
tags = local.common_tags
}

# # Virtual Machines Module
module "vmlinux-n01701496" {
  source               = "./modules/vmlinux-n01701496"
  nb_count = 2
  n01701496_rg_name    = "n01701496-RG"
  location             = "East US"
  linux_avs            = "linux-avs"
  linux_name           =  {
    "n01701496-c-vm1" = "n01701496-c-vm1"
  }
  vm_size          = "Standard_B1s"
  subnet_id            = module.network.subnet_id
  storage_account_uri  = module.common-n01701496.storage_account_uri
  depends_on = [module.rgroup]
  tags                 = local.common_tags
}

module "vmwindows-n01701496" {
  source              = "./modules/vmwindows-n01701496"
  windows_avs          = "windows-avs" 
  location           = "East US"
  n01701496_rg_name    = "n01701496-RG"
  subnet_id          = module.network.subnet_id
  boot_diagnostics_storage_account_uri = module.common-n01701496.storage_account_uri
  vm_count           = 1  
  vm_size          = "Standard_B1s"
  depends_on = [module.rgroup]
  windows              = true 

  tags            =  local.common_tags
}

module "datadisk-n01701496" {
  source              = "./modules/datadisk-n01701496"
  n01701496_rg_name = "n01701496-RG"
  location            = "East US"
  vm_ids              = concat(
    [for key, vm in module.vmlinux-n01701496.vm_details : vm.vm_id],
    module.vmwindows-n01701496.vm_ids
  )
  tags = local.common_tags
  depends_on = [module.rgroup]
}

# Load Balancer Module
module "loadbalancer-n01701496" {
  source                    = "./modules/loadbalancer-n01701496"
  location                  = "East US"
  n01701496_rg_name         = module.rgroup.n01701496_rg_name
  vm_network_interface_ids = concat(
    [for key, vm in module.vmlinux-n01701496.vm_details : vm.nic_id],
    module.vmwindows-n01701496.vm_nic_ids
  )
  tags = local.common_tags
  depends_on = [module.rgroup]
}

module "database-n01701496" {
  source                = "./modules/database-n01701496"
  db_name               = "n01701496-db-instance"
  location             = "East US"
  n01701496_rg_name    = "n01701496-RG"
  admin_username       = "db_admin"
  admin_password       = "P@ssw0rd1234"
  sku_name             = "B_Gen5_1"
  storage_mb           = 5120
  backup_retention_days = 7
  depends_on = [module.rgroup]
  tags                 = local.common_tags
}

