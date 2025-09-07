variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "server_name" { type = string }
variable "db_name" { type = string }
variable "sku_name" { type = string }

variable "sql_admin_login" { type = string }

variable "allowed_ip_address" { type = string }
variable "azure_services_rule_name" { type = string }
variable "verification_rule_name" { type = string }

variable "key_vault_id" { type = string }
variable "sql_admin_name_secret" { type = string }
variable "sql_admin_password_secret" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}