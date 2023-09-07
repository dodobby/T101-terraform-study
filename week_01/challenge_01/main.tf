## 1주차 도전과제 1 : EC2 웹 서버 배포 + 그래프 확인

# Default VPC
data "aws_vpc" "default_vpc" {
  id = var.default_vpc_id
}

# Default Public Subnet
data "aws_subnet" "subnet" {
  cidr_block = var.default_subnet_cidr
}

# Security Group for httpd server
resource "aws_security_group" "ch1-sg" {
  name        = "ch1-test-sg"
  description = "for ch1 test"
  vpc_id      = data.aws_vpc.default_vpc.id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ch1-sg"
  }
}

# ec2 for creating an ami
resource "aws_instance" "web-server" {
  ami                    = var.frank_ubuntu_2204_ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ch1-sg.id]
  key_name               = var.key_pair_name
  subnet_id              = data.aws_subnet.subnet.id
  user_data = <<-EOF
      #!/bin/bash
      apt-get update && apt install -y apache2 && systemctl enable --now apache2 && chmod -R 777 /var/www/html && echo "T101 week1 challenge1" > /var/www/html/index.html
    EOF

  tags = {
    Name = "web-server"
  }
}