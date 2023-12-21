# Regional Azure-specific Resources

> This repository manages regional, Azure-specific resources for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Regional Azure-specific Resources](#regional-azure-specific-resources)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
    * [Development](#development)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Notes](#notes)
  * [Contributors](#contributors)
  * [License](#license)
<!-- TOC -->

## Requirements

- Microsoft Azure [Account](https://azure.microsoft.com/free)
- HashiCorp Cloud Platform (HCP) [Account](https://portal.cloud.hashicorp.com/sign-in).
- HashiCorp Terraform Cloud [Account](https://app.terraform.io/session)
- HashiCorp Terraform `1.6.x` or [newer](https://developer.hashicorp.com/terraform/downloads)

### Development

For development and testing of this repository:

- `terraform-docs` `0.17.0` or [newer](https://terraform-docs.io/user-guide/installation/)

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| location | Location of Resources. | `string` | yes |
| network_address_space | List of CIDRs for Network Address Space. | `list(string)` | yes |
| resource_name_prefix | Prefix of Resource Names. | `string` | yes |
| ssh_public_key | SSH Key of VM Scale Set Instances. | `string` | yes |
| subnet_address_prefixes | List of Address Prefixes for Subnet. | `list(string)` | yes |
| tags | Tags of (supported) Resources. | `map(string)` | yes |
| tenant_id | Identifier of Azure Tenant. | `string` | yes |
| tfe_organization | Name of Terraform Cloud Organization. | `string` | yes |
| tfe_workspace | Name of Terraform Cloud Workspace. | `string` | yes |
| vmss_automatic_os_upgrade_policy | Source Image Reference of VM Scale Set Instances. | <pre>object({<br>    disable_automatic_rollback  = bool<br>    enable_automatic_os_upgrade = bool<br>  })</pre> | yes |
| vmss_rolling_upgrade_policy | Source Image Reference of VM Scale Set Instances. | <pre>object({<br>    cross_zone_upgrades_enabled             = bool<br>    max_batch_instance_percent              = number<br>    max_unhealthy_instance_percent          = number<br>    max_unhealthy_upgraded_instance_percent = number<br>    pause_time_between_batches              = string<br>    prioritize_unhealthy_instances_enabled  = bool<br>  })</pre> | yes |
| vmss_sku | SKU of VM Scale Set Instances. | `string` | yes |
| vmss_source_image_reference | Source Image Reference of VM Scale Set Instances. | <pre>object({<br>    offer     = string<br>    publisher = string<br>    sku       = string<br>    version   = string<br>  })</pre> | yes |
| vmss_user_data | User Data of VM Scale Set Instances. | `string` | yes |
| vmss_username | Username of VM Scale Set Instances. | `string` | yes |
| autoscaling_enabled | Toggle to enable Autoscaling of VM Scale Set Instances. | `bool` | no |
| autoscaling_name | Name of Autoscaling Monitor. | `string` | no |
| autoscaling_profiles | Configuration of Autoscaling Profiles. | <pre>list(object({<br>    name = string<br><br>    capacity = object({<br>      default = number<br>      minimum = number<br>      maximum = number<br>    })<br>  }))</pre> | no |
| autoscaling_rules | Configuration of Autoscaling Rules. | <pre>list(object({<br>    name             = string<br>    operator         = string<br>    statistic        = string<br>    threshold        = number<br>    time_aggregation = string<br>    time_window      = string<br>    time_grain       = string<br><br>    scale_action = object({<br>      cooldown  = string<br>      direction = string<br>      type      = string<br>      value     = string<br>    })<br>  }))</pre> | no |
| ip_address_allocation_method | Allocation Method of Public IP Addresses. | `string` | no |
| ip_address_sku | SKU of Public IP Addresses. | `string` | no |
| ip_address_sku_tier | SKU Tier of Public IP Addresses. | `string` | no |
| ip_address_version | IP Version to use for Public IP addresses. Must be `IPv4` if Allocation Method is `Static`. | `string` | no |
| load_balancer_backend_address_pool_name | Name of Load Balancer Backend Address Pool | `string` | no |
| load_balancer_frontend_ip_name | Name of the Frontend IP Address of Load Balancer Resources. | `string` | no |
| load_balancer_rules | List of Rules for Load Balancer. | <pre>map(object({<br>    backend_port  = number<br>    frontend_port = number<br>    interval      = number<br>    name          = string<br>    protocol      = string<br>  }))</pre> | no |
| load_balancer_sku | SKU of Load Balancer Resources. | `string` | no |
| load_balancer_sku_tier | SKU Tier of Load Balancer Resources. | `string` | no |
| network_dns_servers | List of IP Addresses for Network DNS Servers. | `list(string)` | no |
| storage_account_kind | Kind of Storage Account for Boot Diagnostics. | `string` | no |
| storage_account_name | Name of Storage Account for Boot Diagnostics. | `string` | no |
| storage_account_replication_type | Replication Type of Storage Account for Boot Diagnostics. | `string` | no |
| storage_account_tier | Tier of Storage Account for Boot Diagnostics. | `string` | no |
| subscription_id | Identifier of Azure Subscription. | `string` | no |
| vmms_network_interface | Configuration of Network Interface for VM Scale Set Instances. | <pre>object({<br>    name                          = string<br>    primary                       = bool<br>    enable_accelerated_networking = bool<br>  })</pre> | no |
| vmss_additional_caps_ultra_ssd_enabled | Toggle to enable Ultra SSD Support (additional capability) for VM Scale Set Instances. | `bool` | no |
| vmss_disable_password_authentication | Toggle to Disable Password Authentication of VM Scale Set Instances. | `bool` | no |
| vmss_do_not_run_extensions_on_overprovisioned_machines | Toggle to Prevent running of Extensions on over-provisioned VMs for VM Scale Set Instances. | `bool` | no |
| vmss_eviction_policy | Eviction Policy of VM Scale Set Instances. | `string` | no |
| vmss_instance_repair | Automatic Repair Grace Period of VM Scale Set Instances. | <pre>object({<br>    enabled      = bool<br>    grace_period = string<br>  })</pre> | no |
| vmss_instances | Count of VM Scale Set Instances. | `number` | no |
| vmss_ip_configuration | IP Configuration of VM Scale Set Instances. | <pre>object({<br>    name    = string<br>    primary = bool<br>  })</pre> | no |
| vmss_os_disk_caching | Caching Mode of OS Disk for VM Scale Set Instances. | `string` | no |
| vmss_os_disk_storage_account_type | Storage Account Type of OS Disk for VM Scale Set Instances. | `string` | no |
| vmss_overprovision | Toggle to enable over-provisioning of VM Scale Set VMs. | `bool` | no |
| vmss_priority | Priority of VM Scale Set Instances. | `string` | no |
| vmss_provision_vm_agent | Toggle to enable Provisioning of VM Agent for VM Scale Set Instances. | `bool` | no |
| vmss_public_ip_idle_timeout | Idle Timeout of Public IP Addresses for VM Scale Set Instances. | `number` | no |
| vmss_public_ip_name | Name of Public IP Addresses for VM Scale Set Instances. | `string` | no |
| vmss_termination_notification | Termination Notification of VM Scale Set Instances. | <pre>object({<br>    enabled = bool<br>    timeout = string<br>  })</pre> | no |
| vmss_upgrade_mode | Upgrade Mode of VM Scale Set Instances. | `string` | no |

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

## Notes

* Terraform state may contain [sensitive data](https://developer.hashicorp.com/terraform/language/state/sensitive-data). This workspace uses [Terraform Cloud](https://developer.hashicorp.com/terraform/cloud-docs) to safely store state, and encrypt the data at rest.

## Contributors

For a list of current (and past) contributors to this repository, see [GitHub](https://github.com/workloads/regional-azure-deployment/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may download a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the License for the specific language governing permissions and limitations under the License.
