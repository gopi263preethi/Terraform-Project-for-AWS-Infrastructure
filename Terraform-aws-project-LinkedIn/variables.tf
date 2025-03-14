variable "ami" { 
    description = "ami-id for the instnace"
}

variable "instance_type"  { 
    description = "type of the instance for web application"
}

variable "subnet_id"  { 
    description = "subnet id of aws vpc"
}

variable "security_group_id"  { 
    description = "security group id for inbound and outbound communication"
}