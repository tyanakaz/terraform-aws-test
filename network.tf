resource "aws_vpc" "vpc-1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-1"
  }
}

resource "aws_subnet" "vpc-1-public-subnet" {
  vpc_id            = "${aws_vpc.vpc-1.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "vpc-1-public-subnet"
  }
}

resource "aws_subnet" "vpc-1-private-subnet" {
  vpc_id            = "${aws_vpc.vpc-1.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "vpc-1-private-subnet"
  }
}

resource "aws_internet_gateway" "vpc-1-igw" {
  vpc_id = "${aws_vpc.vpc-1.id}"

  tags = {
    Name = "vpc-1-igw"
  }
}

resource "aws_route_table" "vpc-1-public-rt" {
  vpc_id = "${aws_vpc.vpc-1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc-1-igw.id}"
  }

  tags = {
    Name = "vpc-1-public-rt"
  }
}

resource "aws_route_table_association" "vpc-1-rta-1" {
  subnet_id      = "${aws_subnet.vpc-1-public-subnet.id}"
  route_table_id = "${aws_route_table.vpc-1-public-rt.id}"
}