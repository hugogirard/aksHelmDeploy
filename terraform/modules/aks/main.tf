resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-k8s"
  location            = var.location
  resource_group_name = var.rgName
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = var.subnetId
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
# Was running in a tenant that my SP doesn't have the write role
# If is the case attach with AZ CLI otherewise uncomment this line
# resource "azurerm_role_assignment" "aks_acr" {
#   scope                   = var.acrId
#   role_definition_name    = "AcrPull"
#   principal_id            = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
# }