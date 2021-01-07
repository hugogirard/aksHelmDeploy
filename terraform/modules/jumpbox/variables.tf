variable "location" {
    description = "The location of the resource"
    type = string
}

variable "resourceGroupName" {
    description = "The name of the resource group"
    type = string
}

variable "vm_user" {
    description = "The username of the jumpbox"
    type = string
}

variable "vm_password" {
    description = "The password of the jumpbox"
    type = string
}

variable "subnet_id" {
    description = "The ID of the Subnet"
    type = string
}