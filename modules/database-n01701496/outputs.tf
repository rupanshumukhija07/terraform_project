output "db_instance_name" {
  value       = azurerm_postgresql_server.n01701496_db.name
  description = "The name of the PostgreSQL DB instance"
}
