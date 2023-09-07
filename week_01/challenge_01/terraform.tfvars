region = "eu-central-1"

default_vpc_id = "vpc-07b2cc8e9a65f2ccb"
default_subnet_cidr = "172.31.32.0/20" //subnet-b

frank_ubuntu_2204_ami_id = "ami-04e601abe3e1a910f"
instance_type = "t2.micro"
key_pair_name = "hj-aws-frank-key"

ingress_rules = {
  http = {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  ssh = {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

