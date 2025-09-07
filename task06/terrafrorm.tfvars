# Base prefix for all resource names
name_prefix = "cmaz-wbdw4cma-mod6"

# Azure region
location = "Central US"

# Existing Key Vault info
key_vault_name = "cmaz-wbdw4cma-mod6-kv"
key_vault_rg   = "cmaz-wbdw4cma-mod6-kv-rg"

# IP for SQL Server firewall verification rule
allowed_ip_address = "18.153.146.156"

# SQL admin username (stored in Key Vault)
sql_admin_username = "mod6admin"

# Tags applied to all resources
tags = {
  Creator = "otar_bakhtadze@epam.com"
}
