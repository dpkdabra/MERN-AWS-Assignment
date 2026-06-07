resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "mern-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mern-igw"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "mern-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.igw.id
  }

  tags = {
    Name="public-route"
  }
}

resource "aws_route_table_association" "public_assoc" {

 subnet_id=aws_subnet.public.id

 route_table_id=aws_route_table.public_rt.id

}

resource "aws_route_table" "private_rt" {

 vpc_id=aws_vpc.main.id

 route {
   cidr_block="0.0.0.0/0"
   nat_gateway_id=aws_nat_gateway.nat.id
 }

 tags = {
   Name="private-route"
 }

}

resource "aws_route_table_association" "private_assoc" {

 subnet_id=aws_subnet.private.id

 route_table_id=aws_route_table.private_rt.id

}
