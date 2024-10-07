# Virtual Private Cloud (VPC) Creation 
resource "aws_vpc" "mum-vpc" { 
    cidr_block = "10.2.0.0/16"
}
# Creation of Internet Gateway for External access 
resource "aws_internet_gateway" "mum-igw" {
    vpc_id = aws_vpc.mum-vpc.id

    tags = {
      Name = "Mumbai-InternetGateway"
    }
  
}



# Creation of Subents within the VPC 
resource "aws_subnet" "public-mum1" {
   cidr_block = "10.2.3.0/24"
   availability_zone = "ap-south-1a"
   map_public_ip_on_launch = true
   vpc_id = aws_vpc.mum-vpc.id

   tags = { 
      Name = "Mumbai-Public-Route"
   }
}

# Creation of Route Tablle 
resource "aws_route_table" "mum-rt1" { 
    vpc_id = aws_vpc.mum-vpc.id 

    route { 
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc_id
    }

        tags = { 
            Name = "mum-rt1"
        }
    
}

# Association of Subnet with Route Table
resource "aws_route_table_association" "mum-rt-attach" {
    route_table_id = aws_route_table.mum-rt1.id
    subnet_id = aws_subnet.public-mum1.id
}

# Security Group Configuration
resource "aws_security_group" "main-sg" {
    vpc_id = aws_vpc.mum-vpc

    ingress  {
       from_port = "22"
       to_port = "22"
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    ingress   {
       from_port = "80"
       to_port = "80"
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    ingress  {
       from_port = "443"
       to_port = "443"
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "Default_Security_Group"
    }
  
}


# Listing out the outputs 
# VPC ID
output "vpc_id" {
    value = aws_vpc.mum-vpc.id
}
# Subnet id 
output "subnet_id" {
    value = aws_subnet.public-mum1.id
}
# Security Groups Ids 
output "sg_id" {
    value = vpc_security_group.main-sg.id
}







