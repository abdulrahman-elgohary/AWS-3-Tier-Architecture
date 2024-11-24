#Create a VPC
resource "aws_vpc" "P1_Vpc" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "P1_Vpc"
  }  
}

#Create Public Subnet
resource "aws_subnet" "P1_Public_Subnet" {
  vpc_id     = aws_vpc.P1_Vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true


  tags = {
    Name = "P1_Public_Subnet"
  }
}

#Create Internet Gateway

resource "aws_internet_gateway" "P1_Internet_Gateway" {
  vpc_id = aws_vpc.P1_Vpc.id

  tags = {
    Name = "P1_Internet_Gateway"
  }
}

#Create Route Table for Public Subnet

resource "aws_route_table" "P1_Public_Route_Table" {
  vpc_id = aws_vpc.P1_Vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.P1_Internet_Gateway.id
  }

  tags = {
    Name = "P1_Public_Route_Table"
  }
}

#Associate the Public Subnet to the Route Table
resource "aws_route_table_association" "P1_Public_Subnet_Association" {
  subnet_id      = aws_subnet.P1_Public_Subnet.id
  route_table_id = aws_route_table.P1_Public_Route_Table.id
}