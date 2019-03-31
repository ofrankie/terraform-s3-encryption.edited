variable "aws_region" {
  default = "eu-west-1"
}


variable "base_name" {
  description = "string used to base various names on"
  default = "de-secure"
}

variable "tags" {
  default = {
    "project" = "de-secure"
    "client"  = "Internal"
  }
}

