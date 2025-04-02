variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}

variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "postgresql_version" {
  description = "The version of the PostgreSQL server."
  type        = string
  default     = "11"
}

variable "administrator_login" {
  description = "The administrator login for the PostgreSQL server."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL server."
  type        = string
  default     = "B_Gen5_1"
}

variable "sku_tier" {
  description = "The SKU tier for the PostgreSQL server."
  type        = string
  default     = "Basic"
}

variable "sku_capacity" {
  description = "The capacity for the PostgreSQL server."
  type        = number
  default     = 1
}

variable "storage_mb" {
  description = "The storage size in MB for the PostgreSQL server."
  type        = number
  default     = 5120
}

variable "ssl_enforcement" {
  description = "Enable SSL enforcement."
  type        = string
  default     = "Enabled"
}

variable "backup_retention_days" {
  description = "The number of days to retain backups."
  type        = number
  default     = 7
}

variable "geo_redundant_backup" {
  description = "Enable geo-redundant backups."
  type        = string
  default     = "Disabled"
}

variable "auto_grow" {
  description = "Enable auto grow for storage."
  type        = string
  default     = "Enabled"
}

variable "database_name" {
  description = "The name of the PostgreSQL database."
  type        = string
}

variable "charset" {
  description = "The character set for the database."
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = "The collation for the database."
  type        = string
  default     = "English_United States.1252"
}
