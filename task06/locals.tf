locals {
  # Names derived from the prefix (must match your task parameters exactly)
  rg_name         = format("%s-rg", var.name_prefix)
  sql_server_name = format("%s-sql", var.name_prefix)
  sql_db_name     = format("%s-sql-db", var.name_prefix)
  asp_name        = format("%s-asp", var.name_prefix)
  app_name        = format("%s-app", var.name_prefix)

  # Fixed names from the task
  sql_sku_name  = "S2"   # SQL Database service model
  plan_sku_name = "P0v3" # App Service Plan SKU

  # Firewall rule names
  fw_rule_allow_azure = "allow-azure-services"
  fw_rule_verify_ip   = "allow-verification-ip"

  # Key Vault secret names from the task parameters
  kv_secret_sql_admin_name     = "sql-admin-name"
  kv_secret_sql_admin_password = "sql-admin-password"
}