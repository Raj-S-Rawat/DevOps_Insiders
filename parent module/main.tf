module "azurerm_resource_group" {
  source              = "../child modules/azurerm_resource_group"
  resource_group_name = "Raj-RG"
  location            = "central india"
}

module "azurerm_resource_group1" {
  source              = "../child modules/azurerm_resource_group"
  resource_group_name = "Raj-RG2"
  location            = "central india"
}

module "azurerm_vnet" {
  source              = "../child modules/azurerm_virtual_network"
  resource_group_name = "Raj-RG"
  location            = "central india"
  Vnet_name           = "Raj_Vnet"
  depends_on          = [module.azurerm_resource_group]
}

module "azurerm_Subnet_frontend" {
  source              = "../child modules/azurerm_subnet"
  resource_group_name = "Raj-RG"
  location            = "central india"
  Vnet_name           = "Raj_Vnet"
  subnet_name         = "Raj_subnet_Frontend"
  address_prefix_name = ["10.0.1.0/24"]
  depends_on          = [module.azurerm_vnet]
}

module "azurerm_Subnet_backend" {
  source              = "../child modules/azurerm_subnet"
  resource_group_name = "Raj-RG"
  location            = "central india"
  Vnet_name           = "Raj_Vnet"
  subnet_name         = "Raj_subnet_backend"
  address_prefix_name = ["10.0.2.0/24"]
  depends_on          = [module.azurerm_vnet]
}

module "azurerm_mssql_server" {
  source              = "../child modules/azurerm_sql_server"
  resource_group_name = "Raj-RG"
  location            = "central india"
  mssql_server_name   = "sqlserverraj"
  sqlserver_username  = "rajsqlserver"
  sqlserver_password  = "Qwerty@123"
  depends_on          = [module.azurerm_resource_group]
}

module "azurerm_mssql_database" {
  source              = "../child modules/azurerm_database"
  mssql_db_name       = "Raj-DB"
  resource_group_name = "Raj-RG"
  sql_server_name     = "sqlserverraj"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  depends_on          = [module.azurerm_mssql_server]
}

module "pip_forentend" {
  source              = "../child modules/azurerm_public_ip"
  pip_name            = "PIP_Frontend"
  resource_group_name = "Raj-RG"
  location            = "Central India"
  depends_on          = [module.azurerm_resource_group]
}

module "pip_backend" {
  source              = "../child modules/azurerm_public_ip"
  pip_name            = "PIP_backend"
  resource_group_name = "Raj-RG"
  location            = "Central India"
  depends_on          = [module.azurerm_resource_group]
}

module "VM_frontend" {
  source               = "../child modules/azurerm_virtual_machine"
  subnet_name          = "Raj_subnet_Frontend"
  virtual_network_name = "Raj_Vnet"
  resource_group_name  = "Raj-RG"
  pip_name             = "PIP_Frontend"
  location             = "Central India"
  nic_name             = "nic_frontend"
  todo_VM_name         = "rajfrontendVM"
  VM_username          = "Devops123"
  VM_password          = "Qwerty@123"
  depends_on           = [module.azurerm_resource_group, module.pip_forentend, module.azurerm_Subnet_frontend, module.azurerm_vnet]
}

module "VM_backend" {
  source               = "../child modules/azurerm_virtual_machine"
  subnet_name          = "Raj_subnet_backend"
  virtual_network_name = "Raj_Vnet"
  resource_group_name  = "Raj-RG"
  pip_name             = "PIP_backend"
  location             = "central india"
  nic_name             = "nic_backend"
  todo_VM_name         = "rajbackendVM"
  VM_username          = "Devopsinsider123"
  VM_password          = "Qwerty@123"
  depends_on           = [module.azurerm_resource_group, module.pip_backend, module.azurerm_Subnet_backend, module.azurerm_vnet]
}


