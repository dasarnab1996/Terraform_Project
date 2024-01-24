variable "number_of_subnets" {

    type = number
    description = "Number of subnets"
    

    validation {
      condition = var.number_of_subnets < 10
      error_message = "The number of subnets should be less tham 10"
    }
  
}

variable "number_of_VM" {

    type = number
    description = "How Many VMs to be provisioned"
    
    validation {
      condition = var.number_of_VM < 10
      error_message = "The number of VMs should be less than 10"
    }
  
}

variable "name_of_avset" {

    type = string
    description = "What is the name if the AVSET"
  
}

variable "number_of_fault_domain" {

    type = number
    description = "Number of fault Domian"
  
}

variable "number_of_update_domain" {

    type = number
    description = "Number of update Domain"
}