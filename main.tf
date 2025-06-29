data "azurerm_key_vault" "keyvault" {
  name                = "Devops123keyV"
  resource_group_name = "AJ"
}


resource "azurerm_key_vault_secret" "secrets" {
  name         = "username"
  value        = "Devopsinsiders"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}