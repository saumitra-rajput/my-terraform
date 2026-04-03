# Root Module --calls child modules

# Data source aws_ami id

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create VPC

resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "myvpc"
    }
}

# Create subnet

resource "aws_subnet" "mysub" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.subnet_cidr
  tags = {
    Name = "mysubnet-root"
  }
}


# call the security group module

module "web_sg" {
  source        = "./modules/security-group"
  vpc_id        = aws_vpc.myvpc.id
  sg_name       = "terraweek-web-sg"
  ingress_ports = var.allowed_ports
  tags          = local.common_tags
}

# call the EC2 Module deploy 2 instances

module "web_server" {
    source          = "./modules/ec2-instance"
    ami_id          = data.aws_ami.amazon_linux.id
    instance_type   = var.instance_type
    subnet_id       = aws_subnet.mysub
    security_group_ids = [module.web_sg.sg_id]
    instance_name   = "terraweek-devops-web"
    tags            = local.common_tags
}

# call api_server

module "api_server" {
    source          = "./modules/ec2-instance"
    ami_id          = data.aws_ami.amazon_linux.id
    instance_type   = var.instance_type
    subnet_id       = aws_subnet.mysub
    security_group_ids = [module.web_sg.sg_id]
    instance_name   = "terraweek-devops-api"
    tags            = local.common_tags
}
