output "azurerm_lb" {
  description = "Exported Attributes for `azurerm_lb.main`."
  value       = azurerm_lb.main
}

output "azurerm_lb_backend_address_pool" {
  description = "Exported Attributes for `azurerm_lb_backend_address_pool.main`."
  value       = azurerm_lb_backend_address_pool.main
}

output "azurerm_lb_probe" {
  description = "Exported Attributes for `azurerm_lb_probe.main`."
  value       = azurerm_lb_probe.main
}

output "azurerm_linux_virtual_machine_scale_set" {
  description = "Exported Attributes for `azurerm_linux_virtual_machine_scale_set.main`."
  value       = azurerm_linux_virtual_machine_scale_set.main
  sensitive   = true
}
}

output "azurerm_network_security_group" {
  description = "Exported Attributes for ``azurerm_network_security_group.main`."
  value       = azurerm_network_security_group.main
}

output "azurerm_public_ip" {
  description = "Exported Attributes for `azurerm_public_ip.main`."
  value       = azurerm_public_ip.main
}

output "azurerm_resource_group" {
  description = "Exported Attributes for `azurerm_resource_group`."
  value       = azurerm_resource_group.main
}

output "azurerm_storage_account" {
  description = "Exported Attributes for `azurerm_storage_account`."
  value       = azurerm_storage_account.main
  sensitive   = true
}

output "azurerm_subnet" {
  description = "Exported Attributes for `azurerm_subnet.main`."
  value       = azurerm_subnet.main
}

output "azurerm_ssh_public_key" {
  description = "Exported Attributes for `azurerm_ssh_public_key.main`."
  value       = azurerm_ssh_public_key.main
}

output "azurerm_virtual_network" {
  description = "Exported Attributes for `azurerm_virtual_network.main`."
  value       = azurerm_virtual_network.main
}

output "azurerm_virtual_network_dns_servers" {
  description = "Exported Attributes for ``azurerm_virtual_network_dns_servers.main."
  value       = azurerm_virtual_network_dns_servers.main
}

output "portal_urls" {
  description = "Microsoft Azure Portal URLs."

  value = [
    "https://portal.azure.com/#view/HubsExtension/BrowseAll",
  ]
}
