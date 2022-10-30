resource "azurerm_log_analytics_workspace" "demo_logs" {
  name                = "demo-logs"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}