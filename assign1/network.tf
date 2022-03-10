resource "aws_internet_gateway" "prod-igw" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"
    tags = {
        Name = "sooraj-igw"
    }
}
resource "aws_route_table" "sooraj-public-rt" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"

    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.prod-igw.id}"
    }

    tags = {
        Name = "sooraj-public-rt"
    }
}
resource "aws_route_table" "sooraj-private-rt" {
    vpc_id = "${aws_vpc.sooraj-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.sooNATgw.id}"
    }

    tags = {
        Name = "sooraj-private-rt"
    }
}
resource "aws_route_table_association" "sooraj-public-subnet-1"{
    subnet_id = "${aws_subnet.public-subnet-1.id}"
    route_table_id = "${aws_route_table.sooraj-public-rt.id}"
}
resource "aws_route_table_association" "sooraj-public-subnet-2"{
    subnet_id = "${aws_subnet.public-subnet-2.id}"
    route_table_id = "${aws_route_table.sooraj-public-rt.id}"
}
resource "aws_route_table_association" "sooraj-public-subnet-3"{
    subnet_id = "${aws_subnet.public-subnet-3.id}"
    route_table_id = "${aws_route_table.sooraj-public-rt.id}"
}
resource "aws_route_table_association" "sooraj-private-subnet-1"{
    subnet_id = "${aws_subnet.private-subnet-1.id}"
    route_table_id = "${aws_route_table.sooraj-private-rt.id}"
}
resource "aws_route_table_association" "sooraj-private-subnet-2"{
    subnet_id = "${aws_subnet.private-subnet-2.id}"
    route_table_id = "${aws_route_table.sooraj-private-rt.id}"
}
resource "aws_route_table_association" "sooraj-private-subnet-3"{
    subnet_id = "${aws_subnet.private-subnet-3.id}"
    route_table_id = "${aws_route_table.sooraj-private-rt.id}"
}
resource "aws_eip" "soorajeip" {
    vpc = true
}
resource "aws_nat_gateway" "sooNATgw" {
    allocation_id = aws_eip.soorajeip.id
    subnet_id = aws_subnet.public-subnet-1.id
}
resource "aws_security_group" "sooraj" {
    name = "soorajSG"
    vpc_id = aws_vpc.sooraj-vpc.id

    ingress {
      description = "ALL Traffic"
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
      Name = "SoorajSG"
    }
}
      
