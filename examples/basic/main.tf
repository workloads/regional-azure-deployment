module "main" {
  source = "../.."

  location = var.location

  network_address_space = [
    "10.0.0.0/16"
  ]

  # this will be used as a prefix for all resource names, with the exception of Storage Accounts
  # for SAs, the `resource_name_prefix` will be further modified, to meet API-imposed constraints
  resource_name_prefix = "${var.project_identifier}-${random_string.prefix.result}"

  subnet_address_prefixes = [
    "10.0.1.0/24"
  ]

  ssh_public_key = tls_private_key.main.public_key_openssh

  vmss_automatic_os_upgrade_policy = {
    disable_automatic_rollback  = true
    enable_automatic_os_upgrade = false
  }

  vmss_rolling_upgrade_policy = {
    cross_zone_upgrades_enabled             = false
    max_batch_instance_percent              = 25
    max_unhealthy_instance_percent          = 25
    max_unhealthy_upgraded_instance_percent = 25
    pause_time_between_batches              = "PT10M"
    prioritize_unhealthy_instances_enabled  = true
  }

  vmss_source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-LTS-gen2"
    version   = "latest"
  }

  tags = {
    "github:url"                   = "https://github.com/workloads/regional-azure-deployment"
    "terraform-cloud:organization" = var.tfe_organization
    "terraform-cloud:workspace"    = var.tfe_workspace
  }

  tenant_id        = var.tenant_id
  tfe_organization = var.tfe_organization
  tfe_workspace    = var.tfe_workspace
  vmss_instances   = 1
  vmss_sku         = "Standard_DC1s_v2"
  vmss_user_data   = filebase64("${path.module}/files/user-data.sh")
  vmss_username    = "workloads"
}

