output "azurerm_lb" {
  description = "Exported Attributes for `azurerm_lb.main`."
  value       = module.main.azurerm_lb
}

output "azurerm_lb_backend_address_pool" {
  description = "Exported Attributes for `azurerm_lb_backend_address_pool.main`."
  value       = module.main.azurerm_lb_backend_address_pool
}

output "azurerm_lb_probe" {
  description = "Exported Attributes for `azurerm_lb_probe.main`."
  value       = module.main.azurerm_lb_probe
}

output "azurerm_linux_virtual_machine_scale_set" {
  description = "Exported Attributes for `azurerm_linux_virtual_machine_scale_set.main`."
  value       = module.main.azurerm_linux_virtual_machine_scale_set
  sensitive   = true
}

output "azurerm_monitor_autoscale_setting" {
  description = "Exported Attributes for ``azurerm_monitor_autoscale_setting.main`."
  value       = module.main.azurerm_monitor_autoscale_setting
}

output "azurerm_network_security_group" {
  description = "Exported Attributes for ``azurerm_network_security_group.main`."
  value       = module.main.azurerm_network_security_group
}

output "azurerm_public_ip" {
  description = "Exported Attributes for `azurerm_public_ip.main`."
  value       = module.main.azurerm_public_ip
}

output "azurerm_resource_group" {
  description = "Exported Attributes for `azurerm_resource_group`."
  value       = module.main.azurerm_resource_group
}

output "azurerm_storage_account" {
  description = "Exported Attributes for `azurerm_storage_account`."
  value       = module.main.azurerm_storage_account
  sensitive   = true
}

output "azurerm_subnet" {
  description = "Exported Attributes for `azurerm_subnet.main`."
  value       = module.main.azurerm_subnet
}

output "azurerm_ssh_public_key" {
  description = "Exported Attributes for `azurerm_ssh_public_key.main`."
  value       = module.main.azurerm_ssh_public_key
}

output "azurerm_virtual_network" {
  description = "Exported Attributes for `azurerm_virtual_network.main`."
  value       = module.main.azurerm_virtual_network
}

output "azurerm_virtual_network_dns_servers" {
  description = "Exported Attributes for ``azurerm_virtual_network_dns_servers.main."
  value       = module.main.azurerm_virtual_network_dns_servers
}

output "portal_urls" {
  description = "Microsoft Azure Portal URLs."
  value       = module.main.portal_urls
}
