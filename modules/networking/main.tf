#Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}

# VPC and internet gateway
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.name}-vpc"
  }
}

#Deploy Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidrs[count.index]
  count                   = length(var.public_cidrs)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name" = "${var.name}-public-subnet-${count.index}",
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidrs[count.index]
  count             = length(var.private_cidrs)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name" = "${var.name}-private-subnet-${count.index}",
  }
}

#Route table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    "Name" = "${var.name}-public-rt"
  }
}

resource "aws_route_table_association" "public_route_assoc" {
  count          = length(var.public_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

#Route table for private subnets and associate with NAT gateway
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    "Name" = "${var.name}-private-rt"
  }
}

resource "aws_route_table_association" "private_route_assoc" {
  count          = length(var.private_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# Internet gateway for VPC
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}

# Elastic IP and NAT Gateway
resource "aws_eip" "elastic_ip" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]

  tags = {
    Name = "${var.name}-igw-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id     = aws_eip.elastic_ip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.name}-nat_gateway"
  }
}
