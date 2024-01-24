locals {
  resource_group_name = "App-Resource"
  location = "North Europe"
  virtual_network = {
    name = "ADVNET01"
    ad_space= "10.0.0.0/16"
}

  Az_tags = {
    Environment = "Production"
    Application-Name = "Netflix-India"
    Application-ID = "211109098"
    Business-Service = "Media"

  }
  
}