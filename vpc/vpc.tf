resource "aws_vpc" "prod" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = var.vpc-name
  }

}

resource "aws_subnet" "public-sub-1" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block = var.public-cidr[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc-name}-public-sub-1"
  }

}
resource "aws_subnet" "public-sub-2" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block = var.public-cidr[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc-name}-public-sub-2"
  }

}

resource "aws_subnet" "private-sub-1" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = var.private-cidr[0]
  tags = {
    Name = "${var.vpc-name}-private-sub-1"
  }
}
resource "aws_subnet" "private-sub-2" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = var.private-cidr[1]
  tags = {
    Name = "${var.vpc-name}-private-sub-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "${var.vpc-name}-IGW"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc-name}-Public-RT"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "${var.vpc-name}-Private-RT"
  }
}


resource "aws_route_table_association" "public-association-1" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public-sub-1.id

}
resource "aws_route_table_association" "public-association-2" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public-sub-2.id

}

resource "aws_route_table_association" "private-association-1" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id      = aws_subnet.private-sub-1.id
}

resource "aws_route_table_association" "private-association-2" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id      = aws_subnet.private-sub-2.id
}