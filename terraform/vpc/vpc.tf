resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16" # change cidr block if needed
  tags = {
    Name = "LAMP_MultiTier_VPC"
  }
}

resource "aws_subnet" "web_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.3.0/24" # change cidr block if needed
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "WebSubnet-A"
  }
}

resource "aws_subnet" "app_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.4.0/24" # change cidr block if needed
  availability_zone = "us-east-2a"
  tags = {
    Name = "AppSubnet-A"
  }
}

resource "aws_subnet" "db_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.5.0/24" # change cidr block if needed
  availability_zone = "us-east-2a"
  tags = {
    Name = "DBSubnet-A"
  }
}

# Optional AZ B Support - uncomment if needed

# resource "aws_subnet" "web_subnet_b" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "192.168.6.0/24" # change cidr block if needed
#   availability_zone       = "us-east-2b"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "WebSubnet-B"
#   }
# }

# resource "aws_subnet" "app_subnet_b" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "192.168.7.0/24" # change cidr block if needed
#   availability_zone = "us-east-2b"
#   tags = {
#     Name = "AppSubnet-B"
#   }
# }

 resource "aws_subnet" "db_subnet_b" {
   vpc_id            = aws_vpc.main.id
   cidr_block        = "192.168.8.0/24" # change cidr block if needed
   availability_zone = "us-east-2b"
   tags = {
     Name = "DBSubnet-B"
   }
 }

resource "aws_route_table" "internal" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "InternalRouteTable"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "LAMP_IGW"
  }
}
# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "NAT_EIP"
  }
}

# NAT Gateway in Web Subnet A 

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.web_subnet_a.id

  tags = {
    Name = "LAMP_NAT_Gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "WebPublicRouteTable"
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0" # routes out to the internet
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "web_subnet_a" {
  subnet_id      = aws_subnet.web_subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "app_subnet_a" {
  subnet_id      = aws_subnet.app_subnet_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db_subnet_a" {
  subnet_id      = aws_subnet.db_subnet_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db_subnet_b" {
  subnet_id      = aws_subnet.db_subnet_b.id
  route_table_id = aws_route_table.private.id
}

