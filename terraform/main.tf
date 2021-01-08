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

module "acr" {
  source              = "./modules/containerRegistry"
  prefix              = var.prefix
  rgName              = azurerm_resource_group.rg.name
  location            = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-k8s"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-k8s"
  depends_on = [ azurerm_virtual_network.vnet, azurerm_subnet.aksSubnet ]

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

  private_cluster_enabled = var.private_cluster_enabled

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

# Roles to give to the cluster
resource "azurerm_role_assignment" "aks_acr" {
  scope                   = module.acr.acrId
  role_definition_name    = "AcrPull"
  principal_id            = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}