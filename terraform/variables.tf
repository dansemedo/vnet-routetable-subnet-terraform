
#Resource Group
variable "location" {
    type        = "string"
    description = "Azure location you will deploy the infrastructure"
}

variable "app_rg_name" {
    type        = "string"
    description = "Azure resource group name"
}

#Azure Service Principal

variable "subscription_id" {
    type        = "string"
    description = "Azure subscription ID"
}

variable "client_id" {
    type        = "string"
    description = "Azure Service Principal id (client id)"
}

variable "client_secret" {
    type        = "string"
    description = "Azure client Service Principal secret (client secret)"
}

variable "tenant_id" {
    type        = "string"
    description = "Azure tenant or directory id"
}


#VNET 1 Variables


variable "vnet1_name" {
    type        = "string"
    description = "Azure Vnet 1 Name"
}


#VNET 2 Variables


variable "vnet2_name" {
    type        = "string"
    description = "Azure Vnet 2 Name"
}


#Route Table Variables


variable "route_table_name" {
    type        = "string"
    description = "Azure Route Table Name"
}

#Subnet1 Variables


variable "subnet1_name" {
    type        = "string"
    description = "Subnet1 Name"
}

#Subnet2 Variables


variable "subnet2_name" {
    type        = "string"
    description = "Subnet2 Name"
}

#VNET Peer 1 Variables


variable "vnetpeer1_name" {
    type        = "string"
    description = "VNet peer1 Name"
}

#VNET Peer 2 Variables


variable "vnetpeer2_name" {
    type        = "string"
    description = "VNet peer2 Name"
}