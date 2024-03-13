# Resource group
resource "azurerm_resource_group" "wms_rg" {
  name     = "wms-rg"
  location = var.resource_group_location
}

# Virtual network
resource "azurerm_virtual_network" "wms_vnet" {
  name                = "wms-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.wms_rg.location
  resource_group_name = azurerm_resource_group.wms_rg.name
}

# AKS subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.wms_rg.name
  virtual_network_name = azurerm_virtual_network.wms_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

# AKS cluster
resource "azurerm_kubernetes_cluster" "wms_aks" {
  location            = azurerm_resource_group.wms_rg.location
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  resource_group_name = azurerm_resource_group.wms_rg.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_B2s"
    node_count = var.node_count
  }

  linux_profile {
    admin_username = var.aks_username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}

# ACR
resource "azurerm_container_registry" "acr" {
  name                = "deerwmsacr"
  resource_group_name = azurerm_resource_group.wms_rg.name
  location            = azurerm_resource_group.wms_rg.location
  sku                 = "Basic"
}