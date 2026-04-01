# basic vpc

resource "aws_vpc" "myvpc" {

  cidr_block = var.vpc_cidr

  tags = {
    Name    = "${local.name_prefix}-vpc"
    Project = "${var.project_name}-${var.environment}-vpc"
  }
}

# subnet

resource "aws_subnet" "mysub" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name    = "${local.name_prefix}-sub"
    Project = "${var.project_name}-${var.environment}-subnet"
  }
}

# route table

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name    = "${local.name_prefix}-route"
    Project = "${var.project_name}-${var.environment}-route"
  }
}

# gateway

resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name    = "${local.name_prefix}-gateway"
    Project = "${var.project_name}-${var.environment}-gateway"
  }
}


# route to internet

resource "aws_route" "myri" {
  route_table_id         = aws_route_table.myroute.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mygw.id
}


# route table association

resource "aws_route_table_association" "mya" {
  subnet_id      = aws_subnet.mysub.id
  route_table_id = aws_route_table.myroute.id

}


# security group

resource "aws_security_group" "mysg" {
  name        = "${local.name_prefix}-sec-group"
  vpc_id      = aws_vpc.myvpc.id #interpolation
  description = "This is will have inbound and outbound rule"

  # using dynamic block

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "Port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }


  #	ingress {
  #	description 	  = "SSH"
  #	cidr_blocks 	  = ["0.0.0.0/0"]
  #	from_port 	  = 22
  #	protocol 	  = "tcp"
  #	to_port 	  = 22
  #	}
  #	
  #	ingress {
  #        description       = "HTTP"
  #        cidr_blocks       = ["0.0.0.0/0" ]
  #        from_port         = 80
  #        protocol          = "tcp"
  #        to_port           = 80
  #	}

  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1" # semantically equivalent to all ports all traffic
  }

  tags = {
    Name    = "${local.name_prefix}-sg"
    Project = "${var.project_name}-${var.environment}-sg"
  }
}

# for image id

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


# ec2

resource "aws_instance" "myec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.mysub.id
  vpc_security_group_ids      = [aws_security_group.mysg.id]
  associate_public_ip_address = true
  tags = {
    Name = "${local.name_prefix}-ec2"
  }
}

# s3 bucket 

resource "aws_s3_bucket" "kbucks" {
  bucket = "jarvis-bucks-app-log"

  # explicit dependency
  depends_on = [aws_instance.myec2]
  tags = {
    Name = "${local.name_prefix}-bucket"
  }
}

# acl is deprecated replaced by IAM hence commentedout
#
# resource "aws_s3_bucket_acl" "mykbuck_acl" {
#	bucket = aws_s3_bucket.kbucks.id
#	acl = "private"
#}






