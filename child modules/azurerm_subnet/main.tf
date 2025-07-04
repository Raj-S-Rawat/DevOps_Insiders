resource "azurerm_subnet" "Todo_Subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
      virtual_network_name = var.Vnet_name
  address_prefixes     = var.address_prefix_name
}