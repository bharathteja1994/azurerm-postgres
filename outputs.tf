output "postgresql_flexible_server_id" {
  description = "The ID of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.example.id
}

output "user_assigned_identity_id" {
  description = "The ID of the user-assigned identity"
  value       = azurerm_user_assigned_identity.example.id
}

output "private_endpoint_id" {
  description = "The ID of the private endpoint"
  value       = azurerm_private_endpoint.example.id
}
