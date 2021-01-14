resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rgName
}

resource "azurerm_subnet" "aksSubnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rgName
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_space
}
