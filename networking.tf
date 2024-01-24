
resource "azurerm_resource_group" "AzResourceGr1" {
  name = local.resource_group_name
  location = local.location

}

resource "azurerm_virtual_network" "azvnet1" {
  name                = local.virtual_network.name
  location            = azurerm_resource_group.AzResourceGr1.location
  resource_group_name = azurerm_resource_group.AzResourceGr1.name
  address_space       = [local.virtual_network.ad_space]

  tags = local.Az_tags

  depends_on = [ 
    azurerm_resource_group.AzResourceGr1 ]

}

resource "azurerm_subnet" "az_subnet" {

count = var.number_of_subnets
  name                 = "Subnet-0${count.index}"
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = ["10.0.${count.index}.0/24"]
  
  depends_on = [ azurerm_virtual_network.azvnet1 ]
}



resource "azurerm_network_security_group" "az_nsg" {
  name                = "NSG01"
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "RDP_NSG"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.Az_tags

  depends_on = [ azurerm_resource_group.AzResourceGr1 ]
  }

  resource "azurerm_subnet_network_security_group_association" "az_nsg_association" {
    count = var.number_of_subnets
  subnet_id                 = azurerm_subnet.az_subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.az_nsg.id

  depends_on = [azurerm_virtual_network.azvnet1,azurerm_network_security_group.az_nsg]
}
