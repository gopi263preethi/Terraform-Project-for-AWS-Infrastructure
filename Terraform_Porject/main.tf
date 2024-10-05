provider "aws" {
    region = "ap-south-1"
    access_key = var.access_key
    secret_key = var.secret_key
  
}

module "vpc" {
    source = "./vpc.tf"
}

module "compute" {
    source = "./compute.tf"
  
}