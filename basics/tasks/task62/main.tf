

# basic vpc

resource "aws_vpc" "myvpc" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "jarvis-vpc"
  }
}

# subnet

resource "aws_subnet" "mysub" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "jarvis-sub"
  }
}

# route table

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "jarvis-route"
  }
}

# gateway

resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "jarvis-gateway"
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
  name        = "terra-sec-group"
  vpc_id      = aws_vpc.myvpc.id #interpolation
  description = "This is will have inbound and outbound rule"

	ingress {
	description 	  = "SSH"
	cidr_blocks 	  = ["0.0.0.0/0"]
	from_port 	  = 22
	protocol 	  = "tcp"
	to_port 	  = 22
	}
	
	ingress {
        description       = "HTTP"
        cidr_blocks       = ["0.0.0.0/0" ]
        from_port         = 80
        protocol          = "tcp"
        to_port           = 80
	}
	
	egress {
	from_port	  = 0
	to_port	 	  = 0
  	cidr_blocks       = ["0.0.0.0/0"]
  	protocol       = "-1" # semantically equivalent to all ports all traffic
	}

	tags = {
	Name = "jarvis-sg"
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
	ami 		= data.aws_ami.amazon_linux.id
	instance_type   = "t3.micro"
	subnet_id	= aws_subnet.mysub.id
	vpc_security_group_ids       = [aws_security_group.mysg.id]
	associate_public_ip_address = true
	
	tags = {
	Name = "jarvis-ec2"
	}
}

# s3 bucket 

resource "aws_s3_bucket" "kbucks" {
	bucket = "jarvis-bucks-app-log"

	# explicit dependency
	depends_on = [aws_instance.myec2]
	tags = {
	Name = "jarvis-buck"
	}
}

# acl is deprecated replaced by IAM hence commentedout
#
# resource "aws_s3_bucket_acl" "mykbuck_acl" {
#	bucket = aws_s3_bucket.kbucks.id
#	acl = "private"
#}






