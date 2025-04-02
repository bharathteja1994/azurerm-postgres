resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "kv" {
  name                = "${var.resource_group_name}-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
  tenant_id          = data.azurerm_client_config.current.tenant_id
}

resource "random_password" "admin_password" {
  length  = 16
  special = true
}

resource "azurerm_key_vault_secret" "admin_login" {
  name         = "postgres-admin-login"
  value        = var.administrator_login
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "admin_password_secret" {
  name         = "postgres-admin-password"
  value        = random_password.admin_password.result
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_postgresql_server" "postgresql" {
  name                         = var.postgresql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = var.postgresql_version
  administrator_login          = var.administrator_login
  administrator_login_password = random_password.admin_password.result

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
    family   = var.sku_family
  }

  storage_mb                  = var.storage_mb
  ssl_enforcement_enabled      = var.ssl_enforcement
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup
  auto_grow_enabled            = var.auto_grow
  public_network_access_enabled = var.public_network_access
  infrastructure_encryption_enabled = var.infrastructure_encryption
  create_mode                  = var.create_mode
  geo_redundant_backup_enabled  = var.geo_redundant_backup
  identity {
    type = "SystemAssigned"
  }

  threat_detection_policy {
    enabled            = var.threat_detection_enabled
    email_account_admins = var.email_account_admins
    email_addresses    = var.email_addresses
    retention_days     = var.threat_detection_retention_days
  }

  timeouts {
    create = "60m"
    update = "60m"
    read   = "5m"
    delete = "60m"
  }
}

resource "azurerm_postgresql_database" "database" {
  name                = var.database_name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = var.charset
  collation           = var.collation

  timeouts {
    create = "60m"
    read   = "5m"
    delete = "60m"
  }
}

data "azurerm_client_config" "current" {}
