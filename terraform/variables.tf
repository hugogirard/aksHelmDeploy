variable "prefix" {
  description = "A prefix used for all resources in this example"
  default = "__prefix__"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned"
  default = "__location__"
}

variable "vm_user" {
    description = "The username of the jumpbox"
    type = string
    default = "__vm_user__"
}

variable "vm_password" {
    description = "The password of the jumpbox"
    type = string
    default = "__vm_password__"
}

variable "vnet_name" {
    description = "The name of the vnet containing AKS"
    default = "aks-vnet"
}

variable "private_cluster_enabled" {
    description = "Switch to determine if we are using a private cluster"
    default = false
}

variable "address_space" {
  description = "The address spacing of the VNET"
  type = list(string)
  default = ["10.0.0.0/8"]
}

variable "subnet_name" {
    description = "The address space of the subnet"
    default = "aksSubnet"
}

variable "subnet_address_space" {
  description = "The address space of the subnet containing AKS"
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "jumpbox_subnet_name" {
    description = "The name of the jumpbox subnet"
    default = "jumpboxSubnet"
}

variable "jumpbox_address_space" {
    description = "The address space of the subnet for the jumpbox"
    type = list(string)
    default = ["10.1.0.0/27"]
}

variable "network_docker_bridge_cidr" {
    description = "The docker bridge address space"
    default = "172.17.0.1/16"
}

variable "sqlAdmin" {
  description = "The username of the SQL Server database"
  type = string
  sensitive = true
  default = "__sqlAdmin__"
}

variable "sqlPassword" {
  description = "The password of the sql server database"
  type = string
  sensitive = true
  default = "__sqlPassword__"
}
