resource "aws_vpc" "alchdli_odd_vpc" {
  cidr_block       = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "t101-study"
  }
}

resource "aws_subnet" "alchdli_odd_subnet1" {
  vpc_id     = aws_vpc.alchdli_odd_vpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = "eu-central-1a"

  tags = {
    Name = "t101-subnet1"
  }
}

resource "aws_subnet" "alchdli_odd_subnet2" {
  vpc_id     = aws_vpc.alchdli_odd_vpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = "eu-central-1b"

  tags = {
    Name = "t101-subnet2"
  }
}

resource "aws_internet_gateway" "alchdli_odd_igw" {
  vpc_id = aws_vpc.alchdli_odd_vpc.id

  tags = {
    Name = "t101-igw"
  }
}

resource "aws_route_table" "alchdli_odd_rt" {
  vpc_id = aws_vpc.alchdli_odd_vpc.id

  tags = {
    Name = "t101-rt"
  }
}

resource "aws_route_table_association" "alchdli_odd_rtassociation1" {
  subnet_id      = aws_subnet.alchdli_odd_subnet1.id
  route_table_id = aws_route_table.alchdli_odd_rt.id
}

resource "aws_route_table_association" "alchdli_odd_rtassociation2" {
  subnet_id      = aws_subnet.alchdli_odd_subnet2.id
  route_table_id = aws_route_table.alchdli_odd_rt.id
}

resource "aws_route" "alchdli_odd_defaultroute" {
  route_table_id         = aws_route_table.alchdli_odd_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.alchdli_odd_igw.id
}

output "aws_vpc_id" {
  value = aws_vpc.alchdli_odd_vpc.id
}