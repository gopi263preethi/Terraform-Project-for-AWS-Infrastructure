variable "vpc_id" {
    type = string
}
variable "subnet_id" { 
     type = string 
} 
variable "sg_id" {
type = string 
}
  





resource "aws_instance" "sample_instance" {
    ami = "ami-022ce6f32988af5fa"
    instance_type = "t2.micro"
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.sg_id]
    key_name = "sample-mumbai-keypair"

    tags = {
      Name = "EC2-Instance-IAC"
    }
  
}
