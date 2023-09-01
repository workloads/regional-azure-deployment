# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ssh_public_key
resource "azurerm_ssh_public_key" "main" {
  name                = local.resource_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  public_key = var.ssh_public_key
  tags       = var.tags
}
