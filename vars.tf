variable "aws_region" {
  default = "us-west-2"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "availability_zone" {
  default = "us-west-2a"
}

variable "app_name" {
  default = "WordPress"
}

variable "cidr_vpc" {
  default = "10.0.1.0/24"
}

variable "cidr_subnet" {
  default = "10.0.1.0/26"
}

variable "instance_ami" {
  default = "ami-0a7e1ebfee7a4570e"
}

variable "instance_type" {
  default = "t2.small"
}

variable "key" {
  default = "cm_key"
}
