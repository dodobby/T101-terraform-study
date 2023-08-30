# Default VPC
data "aws_vpc" "default_vpc" {
  id = var.default_vpc_id
}

# Default Public Subnet
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }

  filter {
    name   = "cidr-block"
    values = ["172.31.16.0/20"]
  }
}

resource "aws_security_group" "week01-sg" {
  name        = "week01-test-sg"
  description = "for week01 test"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "week01-sg"
  }
}

/*
resource "aws_instance" "web" {
  ami                    = "ami-0766f68f0b06ab145"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.week01-sg.id]
  key_name               = "hj-k8s-key"
  subnet_id              = data.aws_subnets.subnets.id

  tags = {
    Name = "HelloWorld"
  }
}
*/
