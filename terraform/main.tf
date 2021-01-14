resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-k8s-resources"
  location = var.location
}

module "acr" {
  source              = "./modules/containerRegistry"
  prefix              = var.prefix
  rgName              = azurerm_resource_group.rg.name
  location            = var.location
}

module "vnet" {
  source               = "./modules/network"
  vnet_name            = var.vnet_name
  address_space        = var.address_space
  location             = var.location
  rgName               = azurerm_resource_group.rg.name
  subnet_name          = var.subnet_name
  subnet_address_space = var.subnet_address_space
  prefix               = var.prefix
}

module "aks" {
    source                     = "./modules/aks"
    prefix                     = var.prefix
    location                   = var.location
    rgName                     = azurerm_resource_group.rg.name
    subnetId                   = module.vnet.aksSubnetId
    network_docker_bridge_cidr = var.network_docker_bridge_cidr
    network_dns_service_ip     = var.network_dns_service_ip
    network_service_cidr       = var.network_service_cidr
    private_cluster_enabled    = var.private_cluster_enabled
    acrId                      = module.acr.acrId
}

module "web" {
    source                     = "./modules/webApp"
    prefix                     = var.prefix
    location                   = var.location
    rgName                     = azurerm_resource_group.rg.name
}     

# module "db" {
#   source              = "./modules/sql"
#   prefix              = var.prefix
#   rgName              = azurerm_resource_group.rg.name
#   location            = var.location
#   sqlAdmin            = var.sqlAdmin
#   sqlPassword         = var.sqlPassword
#   depends_on = [ azurerm_virtual_network.vnet ]
# }
