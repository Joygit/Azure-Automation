# Test Environment Variables
resource_group_name        = "rg-azure-automation-test"
location                   = "eastus"
automation_account_name    = ["aa-automation-test", "aa-automation-test2"]  # List of Automation Account names
# automation_account_id      = "aa-automation-test-id"
environment                = "test"
sku_name                   = "Basic"
public_network_access_enabled = true
local_authentication_enabled  = false

tags = {
  environment     = "test"
  project         = "azure-automation"   
}
