# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  features {}

  # The Azure Provider is set to retrieve configuration from the executing environment

  # see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs#skip_provider_registration
  skip_provider_registration = true
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id

  # TODO: remove this when using in TFC
  use_cli = true
}
