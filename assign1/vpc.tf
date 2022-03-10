resource "aws_vpc" "sooraj-vpc" {
    cidr_block = "192.168.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"    
    
    tags = {
        Name = "sooraj-vpc"
    }
}
resource "aws_subnet" "public-subnet-1" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"
    cidr_block = "192.168.0.0/20"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1a"
    
    tags = {
        Name = "public-subnet-1"
    }
}
resource "aws_subnet" "public-subnet-2" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"
    cidr_block = "192.168.16.0/20"
    map_public_ip_on_launch = "true" 
    availability_zone = "ap-southeast-1b"
    
    tags = {
        Name = "public-subnet-2"
    }
}
resource "aws_subnet" "public-subnet-3" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"
    cidr_block = "192.168.32.0/20"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1c"
    
    tags = {
        Name = "public-subnet-3"
    }
}
resource "aws_subnet" "private-subnet-1" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"
    cidr_block = "192.168.48.0/20"
    availability_zone = "ap-southeast-1a"
    
    tags = {
        Name = "private-subnet-1"
    }
}
resource "aws_subnet" "private-subnet-2" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"
    cidr_block = "192.168.64.0/20"
    availability_zone = "ap-southeast-1b"

    tags = {
        Name = "private-subnet-2"
    }
}
resource "aws_subnet" "private-subnet-3" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"
    cidr_block = "192.168.80.0/20"
    availability_zone = "ap-southeast-1c"

    tags = {
        Name = "private-subnet-3"
    }
}
