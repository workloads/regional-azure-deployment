# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "main" {
  name                = local.resource_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "main" {
  name                = local.resource_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.network_address_space

  # DNS Servers are specified in the stand-alone resource at `azurerm_virtual_network_dns_servers.main`
  dns_servers = []

  tags = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers
resource "azurerm_virtual_network_dns_servers" "main" {
  virtual_network_id = azurerm_virtual_network.main.id
  dns_servers        = var.network_dns_servers

  # this resource does not support tags
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "main" {
  name                = local.resource_name
  resource_group_name = azurerm_resource_group.main.name

  address_prefixes = var.subnet_address_prefixes

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#service_endpoints
  service_endpoints = [
    "Microsoft.Storage.Global"
  ]
  virtual_network_name = azurerm_virtual_network.main.name

  # this resource does not support tags
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "main" {
  # TODO: add logic to create one IP per zone

  name                = local.resource_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  allocation_method = var.ip_address_allocation_method
  ip_version        = var.ip_address_version
  sku               = var.ip_address_sku
  sku_tier          = var.ip_address_sku_tier
  tags              = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb
resource "azurerm_lb" "main" {
  name                = local.resource_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb#frontend_ip_configuration
  frontend_ip_configuration {
    name                 = var.load_balancer_frontend_ip_name
    public_ip_address_id = azurerm_public_ip.main.id
  }

  sku      = var.load_balancer_sku
  sku_tier = var.load_balancer_sku_tier
  tags     = var.tags
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool
resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id = azurerm_lb.main.id
  name            = var.load_balancer_backend_address_pool_name
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe
resource "azurerm_lb_probe" "main" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = var.load_balancer_rules

  interval_in_seconds = each.value.interval
  loadbalancer_id     = azurerm_lb.main.id
  name                = "${each.value.name}-probe"
  port                = each.value.backend_port
  protocol            = each.value.protocol
}

# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule
resource "azurerm_lb_rule" "main" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = var.load_balancer_rules

  name = each.value.name

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.main.id
  ]

  backend_port                   = each.value.backend_port
  frontend_port                  = each.value.frontend_port
  frontend_ip_configuration_name = azurerm_lb.main.frontend_ip_configuration.0.name
  loadbalancer_id                = azurerm_lb.main.id
  probe_id                       = azurerm_lb_probe.main[each.key].id
  protocol                       = each.value.protocol
}
