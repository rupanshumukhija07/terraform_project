variable "n01701496_rg_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "log_analytics_workspace" {
  description = "Log Analytics Workspace Configurations"
  type        = map(string)
}

variable "recovery_services_vault" {
  description = "Recovery Services Vault Configurations"
  type        = map(string)
}

variable "storage_account" {
  description = "Storage Account Name"
  type        = string
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
}

