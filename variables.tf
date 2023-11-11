variable "autoscaling_enabled" {
  type        = bool
  description = "Toggle to enable Autoscaling of VM Scale Set Instances."
  default     = true
}

variable "autoscaling_name" {
  type        = string
  description = "Name of Autoscaling Monitor."
  default     = "autoscale"
}

# see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/monitor_autoscale_setting#profile
variable "autoscaling_profiles" {
  type = list(object({
    name = string

    capacity = object({
      default = number
      minimum = number
      maximum = number
    })
  }))

  description = "Configuration of Autoscaling Profiles."

  default = [{
    name = "autoscale"

    capacity = {
      default = 2
      minimum = 1
      maximum = 3
    }
  }]
}

# see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/monitor_autoscale_setting#rule
variable "autoscaling_rules" {
  type = list(object({
    name             = string
    operator         = string
    statistic        = string
    threshold        = number
    time_aggregation = string
    time_window      = string
    time_grain       = string

    scale_action = object({
      cooldown  = string
      direction = string
      type      = string
      value     = string
    })
  }))

  description = "Configuration of Autoscaling Rules."

  default = [{
    # see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/monitor_autoscale_setting#metric_trigger
    name             = "Percentage CPU"
    operator         = "LessThan"
    statistic        = "Average"
    threshold        = 10
    time_aggregation = "Average"
    time_grain       = "PT1M"
    time_window      = "PT2M"

    # see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/monitor_autoscale_setting#scale_action
    scale_action = {
      cooldown  = "PT1M"
      direction = "Decrease"
      type      = "ChangeCount"
      value     = "1"
    }
  }]
}

# `Dynamic` allocated IP Addresses are only known once Azure assigns them to a resource
# Comparatively, `Static` IP Addresses are known early, making it possible to pre-configure DNS records.
variable "ip_address_allocation_method" {
  type        = string
  description = "Allocation Method of Public IP Addresses."
  default     = "Static"
}

variable "ip_address_sku" {
  type        = string
  description = "SKU of Public IP Addresses."
  default     = "Basic"
}

variable "ip_address_sku_tier" {
  type        = string
  description = "SKU Tier of Public IP Addresses."
  default     = "Regional"
}

variable "ip_address_version" {
  type        = string
  description = "IP Version to use for Public IP addresses. Must be `IPv4` if Allocation Method is `Static`."
  default     = "IPv4"
}

variable "load_balancer_backend_address_pool_name" {
  type        = string
  description = "Name of Load Balancer Backend Address Pool"
  default     = "backendpool"
}

variable "load_balancer_frontend_ip_name" {
  type        = string
  description = "Name of the Frontend IP Address of Load Balancer Resources."
  default     = "publicip"
}

variable "load_balancer_rules" {
  type = map(object({
    backend_port  = number
    frontend_port = number
    interval      = number
    name          = string
    protocol      = string
  }))

  description = "List of Rules for Load Balancer."

  default = {
    # ⚠️ `health` is a magic name that is used to trigger certain logic inside `compute.tf`
    health = {
      backend_port  = 22
      frontend_port = 22
      interval      = 30
      name          = "ssh"
      protocol      = "Tcp"
    }

    nomad = {
      backend_port  = 4646
      frontend_port = 4646
      interval      = 30
      name          = "nomad"
      protocol      = "Tcp"
    }
  }
}

variable "load_balancer_sku" {
  type        = string
  description = "SKU of Load Balancer Resources."
  default     = "Basic"
}

variable "load_balancer_sku_tier" {
  type        = string
  description = "SKU Tier of Load Balancer Resources."
  default     = "Regional"
}

variable "location" {
  type        = string
  description = "Location of Resources."
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network#address_space
variable "network_address_space" {
  type        = list(string)
  description = "List of CIDRs for Network Adresss Space."
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network#dns_servers
# and https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers#dns_servers
variable "network_dns_servers" {
  type        = list(string)
  description = "List of IP Addresses for Network DNS Servers."
  default     = []
}

variable "resource_name_prefix" {
  type        = string
  description = "Prefix of Resource Names."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Key of VM Scale Set Instances."
}

variable "storage_account_kind" {
  type        = string
  description = "Kind of Storage Account for Boot Diagnostics."
  default     = "StorageV2"
}

variable "storage_account_name" {
  type        = string
  description = "Name of Storage Account for Boot Diagnostics."
  default     = "diagnostics"
}

variable "storage_account_replication_type" {
  type        = string
  description = "Replication Type of Storage Account for Boot Diagnostics."
  default     = "LRS" # Zone-Redundant Storage (ZRS) is not supported for Boot Diagnostics
}

variable "storage_account_tier" {
  type        = string
  description = "Tier of Storage Account for Boot Diagnostics."
  default     = "Standard"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "List of Address Prefixes for Subnet."
}

variable "subscription_id" {
  type        = string
  description = "Identifier of Azure Subscription."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags of (supported) Resources."
}

variable "tenant_id" {
  type        = string
  description = "Identifier of Azure Tenant."
}

variable "tfe_organization" {
  type        = string
  description = "Name of Terraform Cloud Organization."
}

variable "tfe_workspace" {
  type        = string
  description = "Name of Terraform Cloud Workspace."
}

variable "vmss_additional_caps_ultra_ssd_enabled" {
  type        = bool
  description = "Toggle to enable Ultra SSD Support (additional capability) for VM Scale Set Instances."
  default     = false
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#upgrade_mode
variable "vmss_automatic_os_upgrade_policy" {
  type = object({
    disable_automatic_rollback  = bool
    enable_automatic_os_upgrade = bool
  })

  description = "Source Image Reference of VM Scale Set Instances."
}

variable "vmss_disable_password_authentication" {
  type        = bool
  description = "Toggle to Disable Password Authentication of VM Scale Set Instances."
  default     = true
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#do_not_run_extensions_on_overprovisioned_machines
variable "vmss_do_not_run_extensions_on_overprovisioned_machines" {
  type        = bool
  description = "Toggle to Prevent running of Extensions on Overprovisioned Machines for VM Scale Set Instances."
  default     = true
}

variable "vmss_eviction_policy" {
  type        = string
  description = "Eviction Policy of VM Scale Set Instances."
  default     = "Delete"
}

# automatically repair instances if they become unhealthy
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#automatic_instance_repair
variable "vmss_instance_repair" {
  type = object({
    enabled      = bool
    grace_period = string
  })

  description = "Automatic Repair Grace Period of VM Scale Set Instances."
  default = {
    enabled      = true
    grace_period = "PT30M"
  }
}

variable "vmss_instances" {
  type        = number
  description = "Count of VM Scale Set Instances."
  default     = 0
}

variable "vmss_ip_configuration" {
  type = object({
    name    = string
    primary = bool
  })

  description = "IP Configuration of VM Scale Set Instances."
  default = {
    name    = "ipconfig"
    primary = true
  }
}

variable "vmms_network_interface" {
  type = object({
    name                          = string
    primary                       = bool
    enable_accelerated_networking = bool
  })

  description = "Configuration of Network Interface for VM Scale Set Instances."

  default = {
    name                          = "nic"
    primary                       = true
    enable_accelerated_networking = false
  }
}

variable "vmss_os_disk_caching" {
  type        = string
  description = "Caching Mode of OS Disk for VM Scale Set Instances."
  default     = "ReadWrite"
}

variable "vmss_os_disk_storage_account_type" {
  type        = string
  description = "Storage Account Type of OS Disk for VM Scale Set Instances."
  default     = "Standard_LRS"
}

# allow for overprovisioning, as the instances do not count against quotas and are not billed
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#overprovision
variable "vmss_overprovision" {
  type        = bool
  description = "Toggle to enable Overprovisioning of VM Scale Set Instances."
  default     = true
}

variable "vmss_priority" {
  type        = string
  description = "Priority of VM Scale Set Instances."
  default     = "Spot"
}

variable "vmss_provision_vm_agent" {
  type        = bool
  description = "Toggle to enable Provisioning of VM Agent for VM Scale Set Instances."
  default     = true
}

variable "vmss_public_ip_idle_timeout" {
  type        = number
  description = "Idle Timeout of Public IP Addresses for VM Scale Set Instance(s."
  default     = 30
}

variable "vmss_public_ip_name" {
  type        = string
  description = "Name of Public IP Addresses for VM Scale Set Instances."
  default     = "publicip"
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#upgrade_mode
variable "vmss_rolling_upgrade_policy" {
  type = object({
    cross_zone_upgrades_enabled             = bool
    max_batch_instance_percent              = number
    max_unhealthy_instance_percent          = number
    max_unhealthy_upgraded_instance_percent = number
    pause_time_between_batches              = string
    prioritize_unhealthy_instances_enabled  = bool
  })

  description = "Source Image Reference of VM Scale Set Instances."
}

variable "vmss_sku" {
  type        = string
  description = "SKU of VM Scale Set Instances."
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#upgrade_mode
variable "vmss_source_image_reference" {
  type = object({
    offer     = string
    publisher = string
    sku       = string
    version   = string
  })

  description = "Source Image Reference of VM Scale Set Instances."
}

variable "vmss_termination_notification" {
  type = object({
    enabled = bool
    timeout = string
  })

  description = "Termination Notification of VM Scale Set Instances."
  default = {
    enabled = true
    timeout = "PT5M"
  }
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#upgrade_mode
variable "vmss_upgrade_mode" {
  type        = string
  description = "Upgrade Mode of VM Scale Set Instances."
  default     = "Rolling"
}

variable "vmss_username" {
  type        = string
  description = "Username of VM Scale Set Instances."
}

variable "vmss_user_data" {
  type        = string
  description = "User Data of VM Scale Set Instances."
}

locals {
  # shorthand to allow for future name updates
  resource_name = var.resource_name_prefix

  # Storage Account Name must be lowercase, not contain dashes and be 24 characters at most
  # see https://developer.hashicorp.com/terraform/language/functions/substr
  storage_account_name_replacement = replace("${var.resource_name_prefix}${var.storage_account_name}", "-", "")
  storage_account_name_substr      = substr(local.storage_account_name_replacement, 0, 24)
  storage_account_name             = lower(local.storage_account_name_substr)
}
