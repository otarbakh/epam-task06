# Generate a strong SQL admin password (avoid ';' etc. to keep conn string clean)
resource "random_password" "sql_admin" {
  length           = 20
  special          = true
  override_special = "!#$%&*+-_=?"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
}

resource "azurerm_mssql_server" "this" {
  name                          = var.server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = var.sql_admin_login
  administrator_login_password  = random_password.sql_admin.result
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true
  tags                          = var.tags
}

# Allow Azure services
resource "azurerm_mssql_firewall_rule" "azure_services" {
  name      = var.azure_services_rule_name
  server_id = azurerm_mssql_server.this.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Allow a specific IP (your machine during dev, then verification agent)
resource "azurerm_mssql_firewall_rule" "verify_ip" {
  name      = var.verification_rule_name
  server_id = azurerm_mssql_server.this.id

  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

resource "azurerm_mssql_database" "this" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.this.id
  sku_name       = var.sku_name
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  zone_redundant = false
  tags           = var.tags
}

# Store credentials in the existing Key Vault
resource "azurerm_key_vault_secret" "sql_admin_name" {
  name         = var.sql_admin_name_secret
  value        = var.sql_admin_login
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.sql_admin_password_secret
  value        = random_password.sql_admin.result
  key_vault_id = var.key_vault_id
}

locals {
  adonet_conn_string = format(
    "Server=tcp:%s,1433;Initial Catalog=%s;Persist Security Info=False;User ID=%s;Password=%s;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
    azurerm_mssql_server.this.fully_qualified_domain_name,
    azurerm_mssql_database.this.name,
    var.sql_admin_login,
    random_password.sql_admin.result
  )
}