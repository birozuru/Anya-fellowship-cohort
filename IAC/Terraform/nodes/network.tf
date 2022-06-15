#############################################
# VIRTUAL PRIVATE CLOUD 
#############################################
resource "aws_vpc" "node" {
  cidr_block = "172.26.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = var.name
  }
}

#############################################
# SUBNETS
#############################################
resource "aws_subnet" "node" {
  cidr_block = "${cidrsubnet(aws_vpc.node.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.node.id}"
  availability_zone = var.zone
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "node" {
  vpc_id = "${aws_vpc.node.id}"

  tags = {
    Name = var.name
  }
}

#############################################
# ROUTE TABLE
#############################################
resource "aws_route_table" "node" {
  vpc_id = aws_vpc.node.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.node.id}"
  }

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "node" {
  subnet_id      = aws_subnet.node.id
  route_table_id = aws_route_table.node.id
} 