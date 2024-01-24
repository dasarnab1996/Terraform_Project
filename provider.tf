terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.77.0"
    }
  }
}

provider "azurerm" {
  
subscription_id = "8c715608-1162-4bee-b823-df584118ae30"
client_id = "af622ade-70f7-4e6d-8ad3-63e3819d05f2"
client_secret = "Gm-8Q~nXE8QQccxzS4N.yv_yeifjjCsuZtn1RbfI"
tenant_id = "e7b178ca-5a96-4bc3-8b1c-0f71ee1ab09e"
features {}
}
