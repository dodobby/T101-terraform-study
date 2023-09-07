variable "region" {
  type        = string
  description = "AWS REGION"
}

variable "default_vpc_id" {
  type        = string
  description = "AWS Frank Default VPC ID"
}

variable "default_subnet_cidr" {
  type        = string
  description = "AWS Frank Default Subnet CIDR"
}

variable "frank_ubuntu_2204_ami_id" {
  type = string
  description = "Ubuntu_22.04_ami_id"
}

variable "instance_type" {
  type = string
  description = "ec2_instance_type"
}

variable "key_pair_name" {
  type = string
  description = "ec2 keypair name"
}

variable "ingress_rules" {
  type = map(any)
  description = "web-server-sg-ingress-rules"
}


