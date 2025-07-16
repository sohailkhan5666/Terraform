#VPC CREATION
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "cust-vpc"
    }
}

#PVT SUBNET CREATION
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "pvt-subnet"
    }
}

#PUB SUBNET CREATION
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "pub-subnet"
    }
}

#IG CREATION
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "cust-ig"
    }
}

#PUBLIC RT CREATION
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
}

#PUB RT SUBNET ASSOCIATION
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}

#SG CREATION
resource "aws_security_group" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "cust-sg"
    }
    ingress {
        description = "TLS VPC"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "TLS VPC"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#ELASTIC IP CREATION
resource "aws_eip" "name" {

}

#NAT CREATION
resource "aws_nat_gateway" "name" {
    allocation_id = aws_eip.name.id
    subnet_id = aws_subnet.public.id
    tags = {
        Name = "cust-nat"
    }
    depends_on = [aws_internet_gateway.name]
}

#PVT RT
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.name.id
    }
    tags = {
        Name = "private-rt"
    }
}

#PVT RT SUBNET ASSOCIATION
resource "aws_route_table_association" "name1" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id

}

#EC2 CREATION
resource "aws_instance" "name" {
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.name.id]
}
