data "azurerm_mssql_server" "mssql_server" {
  name                = var.sql_server_name
  resource_group_name = var.resource_group_name
}