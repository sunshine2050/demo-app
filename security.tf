resource "azurerm_sql_firewall_rule" "demo_sql_firewall" {
  name                = "demo-sql-firewall"
  resource_group_name = azurerm_resource_group.demo_rg.name
  server_name         = azurerm_sql_server.demo_sql_serv.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}