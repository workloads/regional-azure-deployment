# Example: `basic`

> This is an example of a _basic_ configuration of the [regional-azure-deployment Module](https://github.com/workloads/regional-azure-deployment)

## Table of Contents

<!-- TOC -->
* [Example: `basic`](#example-basic)
  * [Table of Contents](#table-of-contents)
  * [Usage](#usage)
  * [Module Inputs and Outputs](#module-inputs-and-outputs)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
<!-- TOC -->

## Usage

For a list of usage instructions see the [Readme document](../../README.md) in the root directory.

## Module Inputs and Outputs

For a list of available inputs and outputs, the [Readme document](../../README.md) in the root directory.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| location | Azure Resource Location. | `string` | yes |
| project_identifier | Human-readable Project Identifier. | `string` | yes |
| tenant_id | Identifier of Azure Tenant. | `string` | yes |
| tfe_organization | Name of HCP Terraform Organization. | `string` | yes |
| tfe_workspace | Name of HCP Terraform Workspace. | `string` | yes |

### Outputs

| Name | Description |
|------|-------------|
| azurerm_lb | Exported Attributes for `azurerm_lb.main`. |
| azurerm_lb_backend_address_pool | Exported Attributes for `azurerm_lb_backend_address_pool.main`. |
| azurerm_lb_probe | Exported Attributes for `azurerm_lb_probe.main`. |
| azurerm_linux_virtual_machine_scale_set | Exported Attributes for `azurerm_linux_virtual_machine_scale_set.main`. |
| azurerm_monitor_autoscale_setting | Exported Attributes for `azurerm_monitor_autoscale_setting.main`. |
| azurerm_network_security_group | Exported Attributes for `azurerm_network_security_group.main`. |
| azurerm_public_ip | Exported Attributes for `azurerm_public_ip.main`. |
| azurerm_resource_group | Exported Attributes for `azurerm_resource_group`. |
| azurerm_ssh_public_key | Exported Attributes for `azurerm_ssh_public_key.main`. |
| azurerm_storage_account | Exported Attributes for `azurerm_storage_account`. |
| azurerm_subnet | Exported Attributes for `azurerm_subnet.main`. |
| azurerm_virtual_network | Exported Attributes for `azurerm_virtual_network.main`. |
| azurerm_virtual_network_dns_servers | Exported Attributes for `azurerm_virtual_network_dns_servers.main.` |
| portal_urls | Microsoft Azure Portal URLs. |
<!-- END_TF_DOCS -->
