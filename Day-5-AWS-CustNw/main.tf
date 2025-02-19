#creating vpc
resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "prod_vpc"
    }
  
}
#creating subnet
resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "prod_subnet"
    }
  
}

resource "aws_subnet" "prod_private" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "private-subnet"
    }
  
}
#create elastic ip
resource "aws_eip" "prod" {
    domain = "vpc"
  
}
#create nat gateway
resource "aws_nat_gateway" "prod" {
  subnet_id     = aws_subnet.prod_private.id
  allocation_id = aws_eip.prod.id

  tags = {
    Name = "prod NAT"
  }

}
#create internet gateway
resource "aws_internet_gateway" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
        Name = "prod_ig"
    }
  
}
#create route table and edit routes
resource "aws_route_table" "prod" {
 vpc_id = aws_vpc.prod.id

  route {
    gateway_id = aws_internet_gateway.prod.id
    cidr_block = "0.0.0.0/0"
  }

}
#subnet associations
resource "aws_route_table_association" "prod" {
    route_table_id = aws_route_table.prod.id
    subnet_id = aws_subnet.prod.id
}
#create security group
resource "aws_security_group" "prod" {
    name = "allow"
    description = "Allow inbound traffic"
    vpc_id = aws_vpc.prod.id

    ingress {
        description = "Allow SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow SSH"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

#creation of server
resource "aws_instance" "prod" {
    ami = "ami-0ddfba243cbee3768"
    instance_type = "t2.micro"
    key_name = "mykeypair"
    availability_zone = "ap-south-1b"
    subnet_id = aws_subnet.prod.id
    vpc_security_group_ids = [aws_security_group.prod.id]
  tags = {
    Name = "prod-ec2"
  }
}

#route table for private subnets
resource "aws_route_table" "private_prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
      Name = "private-route-table"
    }
  
}
resource "aws_route" "private_nat" {
    route_table_id = aws_route_table.private_prod.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prod.id
  
}
resource "aws_route_table_association" "private_subnet_association" {
    subnet_id = aws_subnet.prod_private.id
    route_table_id = aws_route_table.private_prod.id
}

#route table for public subnets
resource "aws_route_table" "public_prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
      Name = "public-route-table"
    }
  
}
resource "aws_route" "public_internet" {
    route_table_id = aws_route_table.public_prod.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  
}
