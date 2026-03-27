module "azure_automation" {
  source   = "git::https://github.com/Joygit/Azure-avm-automation-test.git?ref=Master"
  for_each = toset(var.automation_account_name)

  location                = var.location
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_id       = azurerm_resource_group.rg.id
  automation_account_name = each.value
  #   automation_account_id   = var.automation_account_id
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled  = var.local_authentication_enabled
  # user_assigned_identity_id     = var.user_assigned_identity_id

  tags = merge(var.tags, { environment = var.environment })

  depends_on = [azurerm_resource_group.rg]


}

resource "azurerm_automation_runbook" "runbook" {

  for_each = merge([
    for acc_name, runbooks in var.automation_runbooks : {
      for rb_name, rb in runbooks :
      "${acc_name}-${rb_name}" => {
        account = acc_name
        rb      = rb
      }
    }
  ]...)

  name                    = each.value.rb.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = each.value.account

  runbook_type = each.value.rb.runbook_type
  description  = each.value.rb.description

  log_verbose  = try(each.value.rb.log_verbose, false)
  log_progress = try(each.value.rb.log_progress, false)

  # ✅ Use file content ONLY if present
  content = file(each.value.rb.file_path)

  # ✅ Use URI ONLY if present
  # dynamic "publish_content_link" {
  #   for_each = try(each.value.rb.script_uri, null) != null ? [1] : []
  #   content {
  #     uri = each.value.rb.script_uri
  #   }
  # }

   

  depends_on = [module.azure_automation]
}


