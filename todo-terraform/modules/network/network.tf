# Create a VPC
resource "aws_vpc" "yuval-terraform-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = { Name = "${var.env}-yuval-terraform-vpc" }
}

# Create a AWS internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.yuval-terraform-vpc.id
  tags   = { Name = "${var.env}-yuval-terraform-igw" }
}

# create public subnets
resource "aws_subnet" "subnets" {
  count                   = var.num_of_subnets
  vpc_id                  = aws_vpc.yuval-terraform-vpc.id
  cidr_block              = var.cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.env}-yuval-terraform-subnet-${count.index}" }
}

# Create private subnets
resource "aws_subnet" "private_subnets" {
  count                   = var.num_of_subnets
  vpc_id                  = aws_vpc.yuval-terraform-vpc.id
  cidr_block              = var.private_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  tags                    = { Name = "${var.env}-yuval-terraform-private-subnet-${count.index}" }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.yuval-terraform-vpc.id
  tags   = { Name = "${var.env}-yuval-terraform-routetable" }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "route_table_a1" {
  count          = var.num_of_subnets
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.subnets[count.index].id
}


# # Create a NAT Gateway in one of the public subnets
resource "aws_eip" "nat_eip" {
  # vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnets[0].id
  tags          = { Name = "${var.env}-yuval-terraform-nat-gateway" }
}

# Create private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.yuval-terraform-vpc.id
  tags   = { Name = "${var.env}-yuval-terraform-private-routetable" }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private_route_table_associations" {
  count          = var.num_of_subnets
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}

resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.yuval-terraform-vpc.id
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 5000
    to_port     = 5000
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.env}-yuval-terraform-sg" }
}
