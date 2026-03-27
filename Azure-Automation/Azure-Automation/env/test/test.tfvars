# Test Environment Variables
resource_group_name     = "rg-azure-automation-test"
location                = "eastus"
# automation_account_name = ["aa-automation-test", "aa-automation-test2"] # List of Automation Account names
# automation_account_id      = "aa-automation-test-id"
environment                   = "test"
sku_name                      = "Basic"
public_network_access_enabled = true
local_authentication_enabled  = false
system_assigned_identity      = true

automation_account_name = [
  # "aa-automation-test"
  "aa-automation-test2"
]

automation_runbooks = {
  # "aa-automation-test" = {
  #   startVM = {
  #     name         = "startVM"
  #     runbook_type = "PowerShell72"
  #     description  = "Start VM"
  #     runtime      = 7.2
  #     log_verbose  = true
  #     log_progress = true
  #     script_uri   = "https://raw.githubusercontent.com/Joygit/Poweshell-Repo/Master/Powrshell/test.ps1"
  #   }
  # }

  "aa-automation-test2" = {
    stopVM = {
      name         = "stopVM"
      runbook_type = "PowerShell72"
      description  = "Stop VM"
      # runtime      = 7.2
      log_verbose  = true
      log_progress = true
      file_path    = "scripts/stopvm.ps1"
      # content     = <<-EOT
      #   Write-Output "Stopping VM..."
      #   Write-Output "Add your PowerShell code to stop the VM here"
      #   # Add your PowerShell code to stop the VM here
      # EOT

    }
  }
}

tags = {
  environment = "test"
  project     = "azure-automation"
}
