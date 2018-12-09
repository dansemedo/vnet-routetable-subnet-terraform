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

resource "azurerm_route_table" "rt" {
  name                = "${var.route_table_name}"
  location	          ="${azurerm_resource_group.cgrg.location}"
  resource_group_name = "${azurerm_resource_group.cgrg.name}"

    route {
    name                   = "example"
    address_prefix         = "10.100.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
  }

  tags {
    environment = "Production"
  }
}


#Subnet Config
#Subnet Config 1

resource "azurerm_subnet" "subnet1" {
  name                 = "backend"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  resource_group_name  = "${azurerm_resource_group.cgrg.name}"
  route_table_id	     = "${azurerm_route_table.rt.id}"
  address_prefix       = "10.0.2.0/24"
}

output "subnet_id_1" {
  value = "${azurerm_subnet.subnet1.id}"
}

resource "azurerm_subnet_route_table_association" "subnetroute1" {
  subnet_id      = "${azurerm_subnet.subnet1.id}"
  route_table_id = "${azurerm_route_table.rt.id}"
}

#Subnet Config 2

resource "azurerm_subnet" "subnet2" {
  name                 = "backend"
  virtual_network_name = "${azurerm_virtual_network.vnet2.name}"
  resource_group_name  = "${azurerm_resource_group.cgrg.name}"
  route_table_id       = "${azurerm_route_table.rt.id}"
  address_prefix       = "10.0.2.0/24"
}

output "subnet_id_2" {
  value = "${azurerm_subnet.subnet2.id}"
}

resource "azurerm_subnet_route_table_association" "subnetroute2" {
  subnet_id      = "${azurerm_subnet.subnet2.id}"
  route_table_id = "${azurerm_route_table.rt.id}"
}

#VNET Peering config
#VNET Peering 1

resource "azurerm_virtual_network_peering" "vnetpeer1" {
  name                      = "${var.vnetpeer1_name}"
  resource_group_name       = "${azurerm_resource_group.cgrg.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet1.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet2.id}"
}

#VNET Peering 2

resource "azurerm_virtual_network_peering" "vnetpeer2" {
  name                      = "${var.vnetpeer2_name}"
  resource_group_name       = "${azurerm_resource_group.cgrg.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet2.name}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet1.id}"
}