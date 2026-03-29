# this file will create the ec2

provider "aws" {

  region = "us-west-2"
}

# key value pair

resource "aws_key_pair" "my_key_pair" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPgKldDi95OhdwR4u2WgQGC9/LdFQ80Ck5wBLI5Lpmbg friday@LAPTOP-KN42ABNO"

}

# define default VPC

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# security group
resource "aws_security_group" "my_security_group" {
  name        = "terra-sec-group"
  vpc_id      = aws_default_vpc.default.id #interpolation
  description = "This is inbound and outbound rule for ec2 "

}

# inbound and outbound port rules

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# EC2 instance

resource "aws_instance" "my_instance" {

  ami                    = "ami-0d76b909de1a0595d"
  key_name               = aws_key_pair.my_key_pair.key_name
  instance_type          = "t3.micro" # image type
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "terra-server" # instance name
  }
}









