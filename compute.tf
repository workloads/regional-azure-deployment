# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ssh_public_key
resource "azurerm_ssh_public_key" "main" {
  name                = local.resource_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  public_key = var.ssh_public_key

  tags = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set
resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = local.resource_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  admin_username = var.vmss_username

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#additional_capabilities
  additional_capabilities {
    ultra_ssd_enabled = var.vmss_additional_caps_ultra_ssd_enabled
  }

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#admin_ssh_key
  admin_ssh_key {
    username   = var.vmss_username
    public_key = azurerm_ssh_public_key.main.public_key
  }

  # disable automatic "upgrades"
  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#automatic_os_upgrade_policy
  automatic_os_upgrade_policy {
    disable_automatic_rollback  = var.vmss_automatic_os_upgrade_policy.disable_automatic_rollback
    enable_automatic_os_upgrade = var.vmss_automatic_os_upgrade_policy.enable_automatic_os_upgrade
  }

  # automatically repair instances if they become unhealthy
  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#automatic_instance_repair
  automatic_instance_repair {
    enabled      = var.vmss_instance_repair.enabled
    grace_period = var.vmss_instance_repair.grace_period
  }

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#boot_diagnostics
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.main.primary_blob_endpoint
  }

  disable_password_authentication = var.vmss_disable_password_authentication

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#do_not_run_extensions_on_overprovisioned_machines
  do_not_run_extensions_on_overprovisioned_machines = var.vmss_do_not_run_extensions_on_overprovisioned_machines

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#eviction_policy
  eviction_policy = var.vmss_eviction_policy

  health_probe_id = azurerm_lb_probe.main["health"].id

  instances = var.vmss_instances

  network_interface {
    name                          = "nic"
    primary                       = true
    enable_accelerated_networking = false

    ip_configuration {
      name      = var.vmss_ip_configuration_name
      primary   = true
      subnet_id = azurerm_subnet.main.id

      public_ip_address {
        name                    = var.vmss_public_ip_name
        domain_name_label       = local.resource_name
        idle_timeout_in_minutes = var.vmss_public_ip_idle_timeout
      }

      load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.main.id
      ]
    }
  }

  os_disk {
    storage_account_type = var.vmss_os_disk_storage_account_type
    caching              = var.vmss_os_disk_caching
  }

  overprovision      = var.vmss_overprovision
  priority           = var.vmss_priority
  provision_vm_agent = var.vmss_provision_vm_agent

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#rolling_upgrade_policy
  rolling_upgrade_policy {
    cross_zone_upgrades_enabled             = var.vmss_rolling_upgrade_policy.cross_zone_upgrades_enabled
    max_batch_instance_percent              = var.vmss_rolling_upgrade_policy.max_batch_instance_percent
    max_unhealthy_instance_percent          = var.vmss_rolling_upgrade_policy.max_unhealthy_instance_percent
    max_unhealthy_upgraded_instance_percent = var.vmss_rolling_upgrade_policy.max_unhealthy_upgraded_instance_percent
    pause_time_between_batches              = var.vmss_rolling_upgrade_policy.pause_time_between_batches
    prioritize_unhealthy_instances_enabled  = var.vmss_rolling_upgrade_policy.prioritize_unhealthy_instances_enabled
  }

  sku = var.vmss_sku

  source_image_reference {
    publisher = var.vmss_source_image_reference.publisher
    offer     = var.vmss_source_image_reference.offer
    sku       = var.vmss_source_image_reference.sku
    version   = var.vmss_source_image_reference.version
  }

  tags = var.tags

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#terminate_notification
  termination_notification {
    enabled = var.vmss_termination_notification.enabled
    timeout = var.vmss_termination_notification.timeout
  }

  upgrade_mode = var.vmss_upgrade_mode

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#user_data
  user_data = var.vmss_user_data

  # Ignore changes to the instances property, so that the Terraform-managed VM Scale Set resource is not recreated when the instance count changes
  lifecycle {
    # see https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes
    ignore_changes = [
      instances
    ]
  }
}
