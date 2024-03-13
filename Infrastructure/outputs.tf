output "resource_group_name" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.wms_rg.name
}

output "virtual_network_name" {
  description = "The name of the created virtual network."
  value       = azurerm_virtual_network.wms_vnet.name
}

output "subnet_name" {
  description = "The name of the created subnet 1."
  value       = azurerm_subnet.aks_subnet.name
}