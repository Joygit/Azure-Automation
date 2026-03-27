# output "automation_account_id" {
#   description = "Automation Account ID"
#   value       = module.azure_automation.automation_account_id
# }

# output "automation_account_name" {
#   description = "Automation Account Name"
#   value       = module.azure_automation.automation_account_name
# }

output "automation_account_ids" {
  value = {
    for k, v in module.azure_automation :
    k => v.automation_account_id
  }
}

output "automation_account_names" {
  value = {
    for k, v in module.azure_automation :
    k => v.automation_account_name
  }
}

# output "automation_account_endpoint" {
#   description = "Automation Account DSC Endpoint"
#   value       = module.azure_automation.automation_account_dsc_server_endpoint
# }

output "resource_group_id" {
  description = "Resource Group ID"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  description = "Resource Group Name"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "Resource Group Location"
  value       = azurerm_resource_group.rg.location
}
