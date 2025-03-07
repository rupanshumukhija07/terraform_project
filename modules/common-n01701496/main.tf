resource "azurerm_log_analytics_workspace" "la_workspace" {
  name                = var.log_analytics_workspace["law_name"]
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  sku                 = var.log_analytics_workspace["log_sku"]
  retention_in_days   = var.log_analytics_workspace["retention"]
  tags                = var.tags
}

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = var.recovery_services_vault["vault_name"]
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  sku                 = var.recovery_services_vault["vault_sku"]
  tags                = var.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account
  resource_group_name      = var.n01701496_rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

