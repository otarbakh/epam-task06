resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_rg_name
}

module "sql" {
  source = "./modules/sql"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = local.sql_server_name
  db_name             = local.sql_db_name
  sku_name            = local.sql_sku_name

  sql_admin_login = var.sql_admin_login

  allowed_ip_address       = var.allowed_ip_address
  azure_services_rule_name = local.fw_rule_allow_azure
  verification_rule_name   = local.fw_rule_verify_ip

  key_vault_id              = data.azurerm_key_vault.kv.id
  sql_admin_name_secret     = local.kv_secret_sql_admin_name
  sql_admin_password_secret = local.kv_secret_sql_admin_password

  tags = var.tags
}

module "webapp" {
  source = "./modules/webapp"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  asp_name            = local.asp_name
  app_name            = local.app_name
  sku_name            = local.plan_sku_name
  dotnet_version      = "8.0"

  # Sensitive connection string produced by the SQL module
  sql_connection_string = module.sql.sql_connection_string

  tags = var.tags
}