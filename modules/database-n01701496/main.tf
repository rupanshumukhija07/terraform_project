resource "azurerm_postgresql_server" "n01701496_db" {
  name                         = var.db_name
  location                     = var.location
  resource_group_name          = var.n01701496_rg_name
  version                      = "11"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  sku_name                     = var.sku_name
  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = false
  ssl_enforcement_enabled = true
  tags                         = var.tags

  lifecycle {
    ignore_changes = [
      administrator_login_password
    ]
  }
}

resource "azurerm_postgresql_database" "humber_db" {
  name                = var.db_name
  resource_group_name = var.n01701496_rg_name
  server_name         = azurerm_postgresql_server.n01701496_db.name
  charset             = "UTF8"
  collation           = "en_US.UTF8"
}