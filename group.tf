# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "main" {
  name     = local.resource_name
  location = var.location
  tags     = var.tags
}
