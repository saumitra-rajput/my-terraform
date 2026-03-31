

# basic vpc

resource "aws_vpc" "myvpc" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "jarvis_vpc"
  }
}

# subnet

resource "aws_subnet" "mysub" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "jarvis_sub"
  }
}

# route table

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "jarvis_route"
  }
}

# gateway

resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "jarvis_gateway"
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





