variable "rgName" {
    description = "The name of the resource group"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned"
}

variable "sqlAdmin" {
  description = "The username of the SQL Server database"
  type = string
  sensitive = true
}

variable "sqlPassword" {
  description = "The password of the sql server database"
  type = string
  sensitive = true
}
