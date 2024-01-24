
resource "azurerm_availability_set" "az-AvSet" {
  name                = var.name_of_avset
  location            = local.location
  resource_group_name = local.resource_group_name

  platform_fault_domain_count = var.number_of_fault_domain
  platform_update_domain_count = var.number_of_update_domain

  tags = local.Az_tags

  depends_on = [ azurerm_resource_group.AzResourceGr1 ]
}