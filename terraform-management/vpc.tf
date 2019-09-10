resource "aws_vpc" "vpc-default" {
    cidr_block           = "172.31.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags = {
      Name = "default"
      managed = "terraform"
      environment = "management"
    }
}

# Subnets
resource "aws_subnet" "subnet-default-1a" {
    vpc_id                  = "${aws_vpc.vpc-default.id}"
    cidr_block              = "172.31.80.0/20"
    availability_zone       = "${var.region}a"
    map_public_ip_on_launch = true

    tags = {
      managed = "terraform"
      environment = "management"
    }
}
resource "aws_subnet" "subnet-default-1b" {
    vpc_id                  = "${aws_vpc.vpc-default.id}"
    cidr_block              = "172.31.16.0/20"
    availability_zone       = "${var.region}b"
    map_public_ip_on_launch = true

    tags = {
      managed = "terraform"
      environment = "management"
    }
}
resource "aws_subnet" "subnet-default-1c" {
    vpc_id                  = "${aws_vpc.vpc-default.id}"
    cidr_block              = "172.31.32.0/20"
    availability_zone       = "${var.region}c"
    map_public_ip_on_launch = true

    tags = {
      managed = "terraform"
      environment = "management"
    }
}
resource "aws_subnet" "subnet-default-1d" {
    vpc_id                  = "${aws_vpc.vpc-default.id}"
    cidr_block              = "172.31.0.0/20"
    availability_zone       = "${var.region}d"
    map_public_ip_on_launch = true

    tags = {
      managed = "terraform"
      environment = "management"
    }
}
resource "aws_subnet" "subnet-default-1e" {
    vpc_id                  = "${aws_vpc.vpc-default.id}"
    cidr_block              = "172.31.48.0/20"
    availability_zone       = "${var.region}e"
    map_public_ip_on_launch = true

    tags = {
      managed = "terraform"
      environment = "management"
    }
}
resource "aws_subnet" "subnet-default-1f" {
    vpc_id                  = "${aws_vpc.vpc-default.id}"
    cidr_block              = "172.31.64.0/20"
    availability_zone       = "${var.region}f"
    map_public_ip_on_launch = true

    tags = {
      managed = "terraform"
      environment = "management"
    }
}
