variable "prefix" {
  description = "A prefix used for all resources in this example"
  default = "__prefix__"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned"
  default = "__location__"
}

variable "vnet_name" {
    description = "The name of the vnet containing AKS"
    default = "aks-vnet"
}

variable "address_space" {
  description = "The address spacing of the VNET"
  default = "10.0.0.0/8"
}

variable "subnet_name" {
    description = "The address space of the subnet"
    default = "aksSubnet"
}

variable "subnet_address_space" {
  description = "The address space of the subnet containing AKS"
  default = "10.0.0.0/16"
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