resource "azurerm_container_registry" "acr" {
    name                    = "${var.prefix}acr"
    resource_group_name     = var.rgName
    location                = var.location
    sku                     = "Standard"
    admin_enabled           = false
}