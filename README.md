# Azure Automation using Terraform

## Overview

This repository provisions Azure Automation Accounts and Runbooks using Terraform. It supports multiple environments, multiple automation accounts, and multiple runbooks per account. The implementation allows flexible script sourcing using local files, inline content, or remote repositories.

## Repository Structure

The repository is organized to separate infrastructure code, environment configurations, and runbook scripts.

* main.tf: Core resource definitions
* variables.tf: Input variable definitions
* locals.tf: Data transformation and iteration logic
* scripts/: PowerShell scripts used by runbooks
* envs/: Environment-specific variable files (dev, test, prod)

Example structure:

Azure-Automation/
├── main.tf
├── variables.tf
├── locals.tf
├── scripts/
│   ├── startvm.ps1
│   └── stopvm.ps1
└── envs/
├── dev/terraform.tfvars
├── test/terraform.tfvars
└── prod/terraform.tfvars

## Prerequisites

Ensure the following tools are installed:

* Terraform (latest stable version)
* Azure CLI
* Git
* Active Azure subscription

Login to Azure:

az login

Set the subscription:

az account set --subscription "<SUBSCRIPTION_ID>"

Verify subscription:

az account show

## Terraform Deployment

Run all commands from the root directory of the repository.

Initialize Terraform:

terraform init

Validate configuration:

terraform validate

Plan deployment:

terraform plan -var-file="envs/test/terraform.tfvars"

Apply changes:

terraform apply -var-file="envs/test/terraform.tfvars"

Destroy resources (if needed):

terraform destroy -var-file="envs/test/terraform.tfvars"

## Runbook Configuration

Runbooks are defined in the environment-specific tfvars file using a nested map structure.

Example:

automation_runbooks = {
"aa-automation-test" = {
startVM = {
name         = "startVM"
runbook_type = "PowerShell72"
runtime      = 7.2
description  = "Start VM"
log_verbose  = true
log_progress = true
file_path    = "scripts/startvm.ps1"
}
}
}

Each automation account can contain multiple runbooks. Resources are dynamically created using Terraform iteration.

## Script Sourcing Options

The solution supports multiple ways to define runbook content.

Local file/ same repo file:

file_path = "scripts/startvm.ps1"

Remote script:

script_uri = "https://raw.githubusercontent.com/<repo>/<branch>/scripts/startvm.ps1"

Inline content:

content = <<EOF
Write-Output "Starting VM"
EOF

Only one method should be used per runbook.

## Runbook Type and Runtime

The runbook_type must match the supported value for your provider and Azure environment.

In this implementation:

* "PowerShell" is used for PowerShell 5.1
* "PowerShell72" is used for PowerShell 7.2

Ensure the correct value is used based on your environment. Using unsupported values may result in deployment errors.

## Important Notes

* The file() function reads paths relative to the Terraform root directory, not the tfvars location
* Use only one of content, file_path, or script_uri per runbook
* Ensure scripts exist at the specified path before running Terraform
* Keep environment configurations separate using envs folders

## Git Workflow

Clone the repository:

git clone https://github.com/Joygit/Azure-Automation.git

Navigate to the working directory:

cd Azure-Automation/Azure-Automation/Azure-Automation

Create a new branch:

git checkout -b feature/update-runbooks

Add changes:

git add .

Commit changes:

git commit -m "Updated automation runbook configuration"

Push changes:

git push origin feature/update-runbooks

Pull latest changes:

git pull origin Master

## Best Practices

* Keep scripts in the scripts directory
* Use environment-specific tfvars files
* Avoid hardcoding values in Terraform code
* Use version-controlled scripts for production environments
* Validate and review plans before applying

## Future Enhancements

* Add scheduling for runbooks
* Integrate monitoring and alert-based triggers
* Implement CI/CD pipelines


## License

This project can be used for learning and internal implementation. Update licensing as required.
