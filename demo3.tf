provider aws{
 region = "us-west-2"
 access_key = "AKIA2UC3BUOAS7UKM6EW"
 secret_key = "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"
}

#Create VPC

resource "aws_vpc" "VPC01"{
 cidr_block="10.0.0.0/16"
 instance_tenancy="default"

 tags={
   Name="VPC01"
 }
}

#Create Subnet 01

resource "aws_subnet" "SUBNET01"{
 vpc_id=aws_vpc.VPC01.id
 cidr_block="10.0.10.0/24"
 availability_zone="us-west-2a" 
 tags={
   Name="SUBNET01"
 }
}

#Create Subnet 02

resource "aws_subnet" "SUBNET02"{
 vpc_id=aws_vpc.VPC01.id
 cidr_block="10.0.20.0/24"
 availability_zone="us-west-2b"
 tags={
    Name="SUBNET02"
 }
}

#Create Internet Gateway

resource "aws_internet_gateway" "IGW-VPC01"{
 vpc_id=aws_vpc.VPC01.id
 tags={
    Name="IGW-VPC01"
 }
}

#Create a Route Table

resource "aws_route_table" "RT-VPC01"{
 vpc_id=aws_vpc.VPC01.id
 tags={
   Name="RT-VPC01" 
 }
}

#Createa a Route to Internet Gateway

resource "aws_route" "Internet_route"{
 route_table_id=aws_route_table.RT-VPC01.id
 destination_cidr_block="0.0.0.0/0"
 gateway_id = aws_internet_gateway.IGW-VPC01.id
}

#Associate Subnet01 in route table RT-VPC01

resource "aws_route_table_association" "a"{
 route_table_id=aws_route_table.RT-VPC01.id
 subnet_id=aws_subnet.SUBNET01.id 
}


#Associate Subnet02 in route table RT-VPC01

resource "aws_route_table_association" "b"{
 route_table_id=aws_route_table.RT-VPC01.id
 subnet_id=aws_subnet.SUBNET02.id 
}

