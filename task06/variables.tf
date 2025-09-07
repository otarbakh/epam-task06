variable "name_prefix" {
  description = "Base prefix used to construct all resource names."
  type        = string
  default     = "cmaz-wbdw4cma-mod6"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "centralus"
}

variable "kv_rg_name" {
  description = "Existing Key Vault resource group name."
  type        = string
  default     = "cmaz-wbdw4cma-mod6-kv-rg"
}

variable "kv_name" {
  description = "Existing Key Vault name."
  type        = string
  default     = "cmaz-wbdw4cma-mod6-kv"
}

variable "allowed_ip_address" {
  description = "IP address allowed to access SQL Server (will be used for the verification rule)."
  type        = string
}

variable "sql_admin_login" {
  description = "SQL admin username (will be stored in Key Vault)."
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    Creator = "otar_bakhtadze@epam.com"
  }
}
