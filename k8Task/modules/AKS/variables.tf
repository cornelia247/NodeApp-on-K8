
variable "location" {
  default = "West Europe"
}

variable "resource_group_name" {
  
}
variable "sshKey" {
  type = string
}
variable "environment" {
  default = "Dev"
}


variable "serviceprinciple-id" {}

variable "serviceprinciple-secret" {}
