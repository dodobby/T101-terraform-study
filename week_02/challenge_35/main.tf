# Default VPC
data "aws_vpc" "default_vpc" {
  id = var.default_vpc_id
}

// 도전과제 3 : 입력변수 사용
# Default VPC ID
variable "default_vpc_id" {
  type        = string
  description = "AWS Frank Default VPC ID"
}
# Security Group Ingress Rule
variable "ingress_rules" {
  type = map(any)
  description = "web-server-sg-ingress-rules"
}



// 도전과제 5 : count, for_each, dynamic 사용
# Security Group for httpd server
resource "aws_security_group" "ch35-sg" {
  count = 2
  name        = "ch35-test-sg-${count.index}"
  description = "for ch35 test"
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
    Name = "ch35-sg-${count.index}"
  }
}