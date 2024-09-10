terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "aws" {
  # Configuration options
  access_key = "xxxx-xxxxx-xxxxx"
  secret_key =  "xxxx-xxxxxx-xxx"
  region = "us-east-1"
}
