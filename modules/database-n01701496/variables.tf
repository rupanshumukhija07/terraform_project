variable "db_name" {
  description = "The name of the PostgreSQL Database"
  type        = string
}

variable "location" {
  description = "The Azure region where the database will be deployed"
  type        = string
}

variable "n01701496_rg_name" {
  description = "The resource group name in which to deploy the PostgreSQL instance"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the PostgreSQL database"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL database (e.g., B_Gen5_1)"
  type        = string
}

variable "storage_mb" {
  description = "The storage size of the PostgreSQL database in MB"
  type        = number
}

variable "backup_retention_days" {
  description = "The number of days to retain backups for the PostgreSQL database"
  type        = number
}

variable "tags" {
  description = "A map of tags to assign to the PostgreSQL instance"
  type        = map(string)
  default     = {}
}
