# Azure Automation Account Terraform

Simple Terraform configuration for Azure Automation Account deployment in Test environment using the Azure-avm-automation-test module from GitHub.

**Module Source:** [github.com/Joygit/Azure-avm-automation-test](https://github.com/Joygit/Azure-avm-automation-test)  
**Version:** v0.0.1

## Project Structure

```
├── terraform.tf              # Provider and version configuration
├── variables.tf              # Variable definitions
├── data.tf                   # Resource Group creation
├── main.tf                   # Module reference (from GitHub)
├── outputs.tf                # Output values
├── .gitignore
├── README.md
└── env/
    └── test/
        └── test.tfvars       # Test environment configuration
```

## Prerequisites

1. **Azure Subscription** - Valid Pay-As-You-Go subscription
2. **Terraform Installed** - Version >= 1.0
3. **Azure CLI** - Install `az` command

## Setup

### 1. Authenticate to Azure

```bash
az login
az account show  # Verify you're in the correct subscription
```

### 2. Get Your Subscription ID

```bash
az account show --query id -o tsv
```

### 3. Update tfvars File

Edit `env/test/test.tfvars`:

```hcl
subscription_id = "YOUR_ACTUAL_SUBSCRIPTION_ID"  # Replace with output from above
resource_group_name = "rg-azure-automation-test"
...
```

## Usage

### Deploy

```bash
cd env/test
terraform init -var-file="test.tfvars"
terraform plan -var-file="test.tfvars"
terraform apply -var-file="test.tfvars"
```

### View Outputs

```bash
terraform output
```

### Cleanup

```bash
terraform destroy -var-file="test.tfvars"
```

## Variables

- `subscription_id` - Your Azure Subscription ID (required)
- `resource_group_name` - Resource Group name (created by Terraform)
- `location` - Azure region (default: eastus)
- `automation_account_name` - Automation Account name (required)
- `environment` - Environment name (test)
- `sku_name` - SKU: Basic or Free (default: Basic)
- `tags` - Resource tags

## What Gets Created

✅ Resource Group
✅ Automation Account (via GitHub module v0.0.1)
✅ System-Assigned Managed Identity

## Module Details

This configuration uses the `azure-avm-automation-test` module from GitHub:

```hcl
module "azure_automation" {
  source = "github.com/Joygit/Azure-avm-automation-test?ref=v0.0.1"
  ...
}
```

## Notes

- **RG Created Together**: Resource Group and Automation Account are created in one Terraform run
- **Authentication**: Uses `az login` (no service principal needed for practice)
- **Managed Identity**: Automatically created for secure operations
- **Module Source**: Uses latest stable release (v0.0.1) from GitHub
