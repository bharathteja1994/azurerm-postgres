output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "postgresql_server_name" {
  value = azurerm_postgresql_server.postgresql.name
}

output "database_name" {
  value = azurerm_postgresql_database.database.name
}

output "administrator_login" {
  value = azurerm_postgresql_server.postgresql.administrator_login
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

output "admin_password" {
  value     = random_password.admin_password.result
  sensitive = true
}
