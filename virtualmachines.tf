resource "azurerm_network_interface" "az_interface" {
count = var.number_of_VM
  name                = "azvm-nic-0${count.index}"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.az_subnet[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.az_pub_ip[count.index].id
  }

  depends_on = [ azurerm_subnet.az_subnet, azurerm_public_ip.az_pub_ip ]
}

resource "azurerm_public_ip" "az_pub_ip"{

  count = var.number_of_VM
  name                = "Az_PublicIP_0${count.index}"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"

  tags = local.Az_tags

  depends_on = [ azurerm_resource_group.AzResourceGr1 ]
}

resource "azurerm_windows_virtual_machine" "azvm" {

  count = var.number_of_VM
  name                = "${var.name_of_avset}${count.index}"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_D2S_v3"
  admin_username      = "a1_a1azrapp0${count.index}"
  admin_password      = "Arnab@123456123456"
  availability_set_id = azurerm_availability_set.az-AvSet.id

  tags = local.Az_tags

  network_interface_ids = [
    azurerm_network_interface.az_interface[count.index].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

depends_on = [ azurerm_network_interface.az_interface,
azurerm_resource_group.AzResourceGr1 ]

}
