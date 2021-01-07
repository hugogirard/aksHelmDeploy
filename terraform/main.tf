provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-k8s-resources"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "aksSubnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_space
}

resource "azurerm_subnet" "jumpBoxSubnet" {
  name                 = var.jumpbox_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.jumpbox_address_space
}

module "jumpbox" {
  source = "./modules/jumpbox"

  location = azurerm_resource_group.rg.location
  resourceGroupName = azurerm_resource_group.rg.name
  vm_user = var.vm_user
  vm_password = var.vm_password
  subnet_id = azurerm_subnet.jumpBoxSubnet.id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-k8s"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aksSubnet.id
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
    docker_bridge_cidr = var.network_docker_bridge_cidr
    dns_service_ip     = var.network_dns_service_ip
    service_cidr       = var.network_service_cidr    
  }

  identity {
    type = "SystemAssigned"
  }

  private_cluster_enabled = true

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled = false
    }
  }
}