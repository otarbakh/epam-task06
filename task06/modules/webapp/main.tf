resource "azurerm_service_plan" "this" {
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  tags                = var.tags

  site_config {
    always_on  = true
    ftps_state = "Disabled"

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  # App Connection String (shows up in Configuration > Connection strings)
  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }
}