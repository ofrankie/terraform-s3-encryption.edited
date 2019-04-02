variable "aws_region" {
  default = "eu-west-1"
}


variable "dev-base_name" {
  description = "string used to base various names on"
  default = "dev-de-secure"
}

variable "qa-base_name" {
  description = "string used to base various names on"
  default = "qa-de-secure"
}

variable "prod-base_name" {
  description = "string used to base various names on"
  default = "prod-de-secure"
}
variable "tags" {
  default = {
    "project" = "de-secure"
    "client"  = "Internal"
  }
}

