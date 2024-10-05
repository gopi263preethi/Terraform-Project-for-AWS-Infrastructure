variable "vpc_id" {}
variable "subnet-id" {}
variable "sg-id" {}
  





resource "aws_instance" "sample_instance" {
    ami = "ami-022ce6f32988af5fa"
    instance_type = "t2.micro"
    subnet_id = var.subnet-id
    vpc_security_group_ids = var.sg-id
    key_name = "sample-mumbai-keypair"

    tags = {
      Name = "EC2-Instance-IAC"
    }
  
}