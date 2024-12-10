resource "aws_vpc" "some-public" {
    cidr_block = "10.10.0.0/16"
 
    tags = {
 
       Name = "terraform-vpc"
    }
 }

 
resource "aws_internet_gateway" "igw-1" { 
    vpc_id = aws_vpc.some-public.id 

     tags = { 
        Name = "terraform-igw" 
    }
}
 
resource "aws_subnet" "subnet-1"  {
   vpc_id = aws_vpc.some-public.id
   cidr_block = "10.10.50.0/24"
   availability_zone = "ap-south-1b"
   map_public_ip_on_launch = true
   tags = {
       Name = "terraform-public-subnet" 
   } 

}

resource "aws_subnet" "subnet-2" { 
    vpc_id = aws_vpc.some-public.id 
    availability_zone = "ap-south-1c" 
    cidr_block = "10.10.30.0/24"
    map_public_ip_on_launch = true 
    
    tags = { 
        Name = "Terraform-Private-subnet" 
    }
}

resource "aws_route_table" "rt-1" { 
    vpc_id = aws_vpc.some-public.id

    route  { 
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.igw-1.id 
    }
    tags = { 
        Name = "Terraform-Route-Public" 
    }
}

resource "aws_route_table_association" "rta-1" { 
    route_table_id = aws_route_table.rt-1.id
    subnet_id = aws_subnet.subnet-1.id
}

resource "aws_security_group" "sg-1" { 
    vpc_id = aws_vpc.some-public.id 

    ingress { 
        from_port = 80
        to_port =  80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

    ingress { 
        from_port = 22
        to_port =  22 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    
    tags = { 
        Name = "terraform-security-group" 
    }


}




### Deploying an instance in Public-subnet 

resource "aws_instance" "insta-1" {
  ami           = "ami-053b12d3152c0cc71"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-1.id
  key_name      = "sample-mumbai-keypair"
  vpc_security_group_ids = [aws_security_group.sg-1.id] 

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y && sudo apt upgrade -y
  EOF

  tags = {
    Name = "terraform-instance"
  }
}


