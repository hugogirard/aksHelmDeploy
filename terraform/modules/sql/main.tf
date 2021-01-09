resource "azurerm_sql_server" "sqlserver" {
    name = "${var.prefix}-sqlserver"
    resource_group_name = var.rgName
    location = var.location
    version = "12.0"
    administrator_login = var.sqlAdmin
    administrator_login_password = var.sqlPassword
}

resource "azurerm_sql_database" "db" {
    name = "${var.prefix}-tododb"
    resource_group_name = var.rgName
    location = var.location
    server_name = azurerm_sql_server.sqlserver.name
}