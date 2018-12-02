resource "azurerm_resource_group" "cgrg" {
  name     = "${var.app_rg_name}"
  location = "${var.location}"
}

#VNET Config
#VNET Config 1

resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.vnet1_name}"
  resource_group_name = "${azurerm_resource_group.cgrg.name}"
  address_space       = ["10.0.1.0/24"]
  location            = "${azurerm_resource_group.cgrg.location}"
}


# VNET Config 2

resource "azurerm_virtual_network" "vnet2" {
  name                = "${var.vnet2_name}"
  resource_group_name = "${azurerm_resource_group.cgrg.name}"
  address_space       = ["10.0.2.0/24"]
  location            = "${azurerm_resource_group.cgrg.location}"
}

#Route table config

data "azurerm_route_table" "rt" {
  name                = "${var.route_table_name}"
  resource_group_name = "${azurerm_resource_group.cgrg.name}"
}
output "route_table_id" {
  value = "${data.azurerm_route_table.rt.id}"
}

#Subnet Config
#Subnet Config 1

data "azurerm_subnet" "subnet1" {
  name                 = "backend"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  resource_group_name  = "${azurerm_resource_group.cgrg.name}"
  route_table_id	     = "${data.azurerm_route_table.rt.route_table_id}"
}

output "subnet_id" {
  value = "${data.azurerm_subnet.subnet1.id}"
}

#Subnet Config 2

data "azurerm_subnet" "subnet2" {
  name                 = "backend"
  virtual_network_name = "${azurerm_virtual_network.vnet2.name}"
  resource_group_name  = "${azurerm_resource_group.cgrg.name}"
  route_table_id	     = "${data.azurerm_route_table.rt.route_table_id}"
}

output "subnet_id" {
  value = "${data.azurerm_subnet.subnet2.id}"
}

#VNET Peering config
#VNET Peering 1

resource "azurerm_virtual_network_peering" "peer1" {
  name                      = "peer1to2"
  resource_group_name       = "${azurerm_resource_group.cgrg.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet1.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet2.id}"
}

#VNET Peering 2

resource "azurerm_virtual_network_peering" "peer2" {
  name                      = "peer2to1"
  resource_group_name       = "${azurerm_resource_group.cgrg.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet2.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet1.id}"
}