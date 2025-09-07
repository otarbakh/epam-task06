output "sql_server_fqdn" {
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
  description = "Fully qualified domain name of the SQL Server"
}

output "sql_connection_string" {
  value       = local.adonet_conn_string
  description = "ADO.NET SQL auth connection string"
  sensitive   = true
}