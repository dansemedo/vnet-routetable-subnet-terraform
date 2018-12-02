resource "azurerm_resource_group" "cg-rg" {
  name     = "${var.app_rg_name}"
  location = "${var.location}"
}

#VNET Config
#VNET Config 1

resource "azurerm_virtual_network" "test1" {
  name                = "peternetwork1"
  resource_group_name = "${azurerm_resource_group.test.name}"
  address_space       = ["10.0.1.0/24"]
  location            = "West US"
}

# VNET Config 2

resource "azurerm_virtual_network" "test2" {
  name                = "peternetwork2"
  resource_group_name = "${azurerm_resource_group.test.name}"
  address_space       = ["10.0.2.0/24"]
  location            = "West US"
}

output "virtual_network_id" {
  value = "${data.azurerm_virtual_network.test.id}"
}

#Route table config

data "azurerm_route_table" "test" {
  name                = "myroutetable"
  resource_group_name = "some-resource-group"
}
output "route_table_id" {
  value = "${data.azurerm_route_table.test.id}"
}

#Subnet Config
#Subnet Config 1

data "azurerm_subnet" "test1" {
  name                 = "backend"
  virtual_network_name = "production"
  resource_group_name  = "networking"
}

output "subnet_id" {
  value = "${data.azurerm_subnet.test.id}"
}

#Subnet Config 2

data "azurerm_subnet" "test2" {
  name                 = "backend"
  virtual_network_name = "production"
  resource_group_name  = "networking"
}

output "subnet_id" {
  value = "${data.azurerm_subnet.test.id}"
}

#VNET Peering config
#VNET Peering 1

resource "azurerm_virtual_network_peering" "test1" {
  name                      = "peer1to2"
  resource_group_name       = "${azurerm_resource_group.test.name}"
  virtual_network_name      = "${azurerm_virtual_network.test1.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.test2.id}"
}

#VNET Peering 2

resource "azurerm_virtual_network_peering" "test2" {
  name                      = "peer2to1"
  resource_group_name       = "${azurerm_resource_group.test.name}"
  virtual_network_name      = "${azurerm_virtual_network.test2.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.test1.id}"
}