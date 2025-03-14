terraform { 
    required_providers { 
        aws = { 
            source = "hashicorp/aws"
            version = "~>3.27"
        }
    }
}

provider  "aws"  { 
    region = "ap-south-1"
}

resource "aws_instance"  "sample"  { 
    ami = var.ami
    instance_type = var.instance_type
    key_name = "sample-mumbai-keypair"
    vpc_security_group_ids = [var.security_group_id]
    subnet_id = var.subnet_id

    tags = { 
        Name = "terraform-instance"
    }
}