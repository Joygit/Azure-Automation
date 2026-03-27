module "azure_automation" {
  source = "github.com/Joygit/Azure-avm-automation-test?ref=Master"
   for_each = toset(var.automation_account_name)

  location                = var.location
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_id       = azurerm_resource_group.rg.id
  automation_account_name = each.value
#   automation_account_id   = var.automation_account_id
  sku_name                = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled  = var.local_authentication_enabled
  user_assigned_identity_id     = var.user_assigned_identity_id
  tags                    = merge(var.tags, { environment = var.environment })

  depends_on = [azurerm_resource_group.rg]
}
