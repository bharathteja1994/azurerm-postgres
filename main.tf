resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_postgresql_flexible_server" "example" {
  name                = var.server_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  administrator_login = var.admin_username
  administrator_password = var.admin_password
  version             = "13"
  sku_name            = "Standard_B1ms"
  storage_mb          = 32768
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  tags     = var.tags

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }

  authentication {
    active_directory_auth_enabled = true
  }

  private_dns_zone_id = azurerm_private_dns_zone.example.id

  #data_encryption {
  #  type = "UserAssigned"
  #  key_vault_key_id = var.key_vault_key_id
  #}
}

resource "azurerm_user_assigned_identity" "example" {
  name                = var.identity_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  tags     = var.tags
}

resource "azurerm_private_endpoint" "example" {
  name                = var.private_endpoint_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = var.subnet_id
  tags     = var.tags

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_postgresql_flexible_server.example.id
    is_manual_connection           = false
    subresource_names              = ["postgresqlServer"]
  }
}

resource "azurerm_private_dns_zone" "example" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.example.name
  tags     = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "example-link"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = var.virtual_network_id
  tags     = var.tags
}
