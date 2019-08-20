# Master scipt for VPC/Subnet/SG setup

terraform {
  backend "s3" {
    bucket                      = "wordpress-tfstate"
    key                         = "wordpress-tfstate/terraform.tfstate"
    region                      = "us-west-2"
    skip_credentials_validation = true
  }
}

# AWS Provider

provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

# VPC resource
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_vpc}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.app_name}"
  }
}

# IG
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.app_name}"
  }
}

# Subnet
resource "aws_subnet" "subnet_public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.cidr_subnet}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.availability_zone}"

  tags = {
    Name = "${var.app_name}"
  }
}

# SG
resource "aws_security_group" "cm_sg" {
  name   = "cm_sg"
  vpc_id = "${aws_vpc.vpc.id}"

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}"
  }
}

# Route Table
resource "aws_route_table" "route_public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "${var.app_name}"
  }
}

# Route Table Association
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = "${aws_subnet.subnet_public.id}"
  route_table_id = "${aws_route_table.route_public.id}"
}
