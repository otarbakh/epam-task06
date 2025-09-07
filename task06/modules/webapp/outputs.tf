output "hostname" {
  description = "Default hostname for the Linux Web App"
  value       = azurerm_linux_web_app.this.default_hostname
}