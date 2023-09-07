# 도전과제4 : AWS 서비스 리소스 배포 + 리소스 생성 그래프 확인
# Resource: aws_network_acl_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule


resource "aws_vpc" "foo" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_network_acl" "bar" {
  vpc_id = aws_vpc.foo.id
}

resource "aws_network_acl_rule" "bar" {
  network_acl_id = aws_network_acl.bar.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.foo.cidr_block
  from_port      = 22
  to_port        = 22
}