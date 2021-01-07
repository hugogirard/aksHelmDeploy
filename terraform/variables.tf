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
    default = ["10.0.1.0/27"]
}

variable "network_docker_bridge_cidr" {
    description = "The docker bridge address space"
    default = "172.17.0.1/16"
}

variable "network_dns_service_ip" {
    description = "The DNS Service IP"
    default = "10.2.0.10"
}

variable "network_service_cidr" {
    description = "The service CIDR"
    default = "10.2.0.0/24"
}