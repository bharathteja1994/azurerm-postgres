variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "server_name" {
  description = "The name of the PostgreSQL server"
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the PostgreSQL server"
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "identity_name" {
  description = "The name of the user-assigned identity"
  type        = string
}

variable "private_endpoint_name" {
  description = "The name of the private endpoint"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the private endpoint"
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network for the private DNS zone link"
  type        = string
}

variable "key_vault_key_id" {
  description = "The ID of the Key Vault key for data encryption"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = list(object)
}
